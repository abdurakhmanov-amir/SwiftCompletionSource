//
//  SomeService.swift
//  SwiftCompletionSource_Example
//
//  Created by Amir on 05.04.2025.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import Foundation

class SomeService {
    func doSomeWork(_ input: Int, _ completionHandler: @escaping (Error?, Int) -> Void) {
        if input > 1 {
            completionHandler(SomeServiceError.lessThanOne, 0)
        }
        
        var result = 0
        
        for i in 0...input {
            result = result + i
        }
        
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { timer in
            completionHandler(nil, result)
        }
    }
}

enum SomeServiceError: Error {
    case lessThanOne
}

extension SomeServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .lessThanOne:
            return String(localized: "input must be greater than 1")
        }
    }
}


