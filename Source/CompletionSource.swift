//
//  CompletionSource.swift
//  SwiftCompletionSource
//
//  Created by Amir on 05.04.2025.
//

public class CompletionSource<TResult> {
    private var _id : UUID
    private let _notificationName : Notification.Name
    
    private var _isCompleted = false
    private var _isCanceled = false
    
    private var _result: TResult?
    
    public init() {
        _id = UUID()
        _notificationName = Notification.Name("\(_id.uuidString)_taskCompletionNotification")
    }
    
    public func waitForCompletion() async -> TResult? {
        for await _ in NotificationCenter.default.notifications(named: _notificationName) {
            if _isCompleted || _isCanceled {
                break;
            }
        }
        
        if _isCanceled {
            return nil
        }
        
        return _result
    }
    
    public func setResult(_ result: TResult) {
        if _isCompleted || _isCanceled {
            return
        }
        
        _result = result
        _isCompleted = true
        
        NotificationCenter.default.post(name: _notificationName, object: nil)
    }
    
    public func cancel() {
        if _isCompleted || _isCanceled {
            return
        }
        
        _isCanceled = true
        
        NotificationCenter.default.post(name: _notificationName, object: nil)
    }
}
