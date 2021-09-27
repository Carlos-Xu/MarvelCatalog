//
//  asdf.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 21/7/21.
//

import Foundation
import Alamofire
import RxSwift

/// Receives a closure that generates Alamofire requests and wraps the request inside a RxSingle.
///
/// Generates a new request each time the request is performed or retried.
/// - Parameter requestGenerator: A closure that returns a generated Alamofire DataRequest
/// - Returns: An RxSingle that emits the response from it's request.
func rxPerformRequest(requestGenerator: @escaping () throws -> DataRequest) -> Single<String> {
    Single<String>.create { observer in
        let request: DataRequest
        
        do {
            request = try requestGenerator()
        } catch {
            observer(.failure(error))
            return Disposables.create()
        }
        
        request.responseString { response in
            if let error = response.error {
                observer(.failure(error))
                return
            }
            
            guard let responseString = response.value else {
                observer(.failure(RepositoryError.empty_response))
                return
            }
            observer(.success(responseString))
        }
        
        return Disposables.create{
            request.cancel()
        }
    }
}

/// Receives a closure that generates Alamofire requests and wraps the request inside a RxSingle.
///
/// The request will be performed upon subscription
///
/// - Parameters:
///   - type: response type.
///   - decoder: Decoder used to decode the response.
///   - requestGenerator: A closure that returns a generated Alamofire DataRequest
/// - Returns: An RxSingle wrapping a request.
func rxPerformRequestDecodable<T>(of type: T.Type = T.self, decoder: Alamofire.DataDecoder = JSONDecoder(), requestGenerator: @escaping () throws -> DataRequest) -> Single<T> where T: Decodable {
    return Single<T>.create { observer in
        let request: DataRequest
        
        do {
            request = try requestGenerator()
        } catch {
            observer(.failure(error))
            return Disposables.create()
        }
        
        request.responseDecodable(of: type, decoder: decoder) { response in
            if let error = response.error {
                var dataString: String? = nil
                if let data = response.data {
                    dataString = String(data: data, encoding: .utf8)
                }
                
                observer(.failure(RepositoryError.general_error(wrappedError: error, responseString: dataString)))
                return
            }
            
            guard let responseValue = response.value else {
                observer(.failure(RepositoryError.empty_response))
                return
            }
            observer(.success(responseValue))

        }
        
        return Disposables.create{
            request.cancel()
        }
    }
}
