//
//  UniqueStrProvider.swift
//  MarvelCatalog
//
//  Created by Carlos Xu on 20/7/21.
//

import Foundation

private var incremental: Int = 0
private let incrementalsSemaphore = DispatchSemaphore(value: 1)

private func getIncremental() -> Int {
    incrementalsSemaphore.wait()
    
    // increment
    incremental += 1
    
    let returnValue = incremental
    
    incrementalsSemaphore.signal()
    
    return returnValue
}


func genUniqueString() -> String {
    // not using epoch because we really don't care abount the time. timeIntervalSinceReferenceDate is shorter
    let time = Date().timeIntervalSinceReferenceDate
    let millis = Int64(time * 1000).toCompressedString()

    // added security: guards against cases where two sucessive calls have the same time
    let incremental = getIncremental().toCompressedString()
    
    // FIXME: replace with unique device identifier to ensure two calls from different devices always produce different unique strings
    let deviceId = Int.random(in: 0..<1000).toCompressedString()
    
    // added security: when the user changes the device time we can run into cases where the time, incremental and deviceId are the same. This is not the safest method, but it's the simplest
    let hexRandomNum = Int.random(in: 0..<1000).toCompressedString()
    
    return "\(millis)/\(incremental)/\(deviceId)/\(hexRandomNum)"
}