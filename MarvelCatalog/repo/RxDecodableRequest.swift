//
//  WrappableRequest.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 26/7/21.
//

import Foundation
import Alamofire
import RxSwift

/// Wrapper class capable of generating a new Alamofire request each time it is performed or retried. Wraps execution of the request inside RxSingle.
class RxDecodableRequest<T: Decodable> {
   
    private let requestGenerator: () throws -> DataRequest
    private let decoder: Alamofire.DataDecoder
    
    /// Initializes the class with an Decoder and a request generator
    /// - Parameters:
    ///   - decoder: The object tha will decode the response into the class T.
    ///   - requestGenerator: A closure that generates a DataRequest every time it is called.
    init(decoder: Alamofire.DataDecoder, requestGenerator: @escaping () throws -> DataRequest) {
        self.decoder = decoder
        self.requestGenerator = requestGenerator
    }
    
    /// Generates an Alamofire request every time it is called.
    /// - Throws: Error if any.
    /// - Returns: DataRequest.
    func generageAFRequest() throws -> DataRequest {
        return try requestGenerator()
    }
    
    /// Generates a RxSingle with a new DataRequest. The request will be performed upon subscription.
    /// - Returns: Request's RxSingle.
    func genRxRequest() -> Single<T> {
        return rxPerformRequestDecodable(of: T.self, decoder: decoder, requestGenerator: requestGenerator)
    }
    
}

