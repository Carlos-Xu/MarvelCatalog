//
//  MySchedulers.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 21/7/21.
//

import Foundation
import RxSwift

/**
 Provides schedulers for RxSwift operations
 */
protocol MySchedulers {
  
    func ui() -> SchedulerType
    
    func serial(qos: DispatchQoS) -> SchedulerType
    
    func concurrent(qos: DispatchQoS) -> SchedulerType

}

final class MySchedulersImplementation: MySchedulers {
    
    func ui() -> SchedulerType {
       return MainScheduler.instance
    }
    
    func serial(qos: DispatchQoS) -> SchedulerType {
        return SerialDispatchQueueScheduler.init(qos: qos)
    }
    
    func concurrent(qos: DispatchQoS) -> SchedulerType {
        return ConcurrentDispatchQueueScheduler.init(qos: qos)
    }
    
}
