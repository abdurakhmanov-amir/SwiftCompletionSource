//
//  SomeServiceWrapper.swift
//  SwiftCompletionSource_Example
//
//  Created by Amir on 05.04.2025.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import SwiftCompletionSource


class SomeServiceWrapper {
    
    private var _service: SomeService
    private var _completionSource: CompletionSource<Int>?
    
    init(_ service: SomeService) {
        _service = service
    }
    
    func doWork(_ input: Int) async -> Int?{
        if let _completionSource {
            _completionSource.cancel()
        }
        
        _completionSource = CompletionSource<Int>()
        
        _service.doSomeWork(5) { error, result in
            guard let completionSource = self._completionSource else {
                return
            }
            
            if let error {
                completionSource.cancel()
            }
            
            completionSource.setResult(result)
        }
        
        return await _completionSource!.waitForCompletion()
    }
}
