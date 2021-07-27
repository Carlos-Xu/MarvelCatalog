//
//  WrappableRequest.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 26/7/21.
//

import Foundation
import Alamofire
import RxSwift

/**
 Wrapper class capable of generating a new Alamofire request each time it is performed or retried. Wraps execution of the request inside Rx Single.
 */
class RxDecodableRequest<T: Decodable> {
   
    private let requestGenerator: () throws -> DataRequest
    private let decoder: Alamofire.DataDecoder
    
    init(decoder: Alamofire.DataDecoder, requestGenerator: @escaping () throws -> DataRequest) {
        self.decoder = decoder
        self.requestGenerator = requestGenerator
    }
    
    func generageAFRequest() throws -> DataRequest {
        return try requestGenerator()
    }
    
    func performRequest() -> Single<T> {
        return rxPerformRequestDecodable(of: T.self, decoder: decoder, requestGenerator: requestGenerator)
    }
    
}

