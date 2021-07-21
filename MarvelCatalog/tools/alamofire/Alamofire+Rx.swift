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
