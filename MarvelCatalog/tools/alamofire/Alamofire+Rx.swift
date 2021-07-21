//
//  asdf.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 21/7/21.
//

import Foundation
import Alamofire
import RxSwift

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
                observer(.failure(error))
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
