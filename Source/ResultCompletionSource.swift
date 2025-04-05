//
//  ResultCompletionSource.swift
//  Pods-SwiftCompletionSource_Example
//
//  Created by Amir on 05.04.2025.
//

public class ResultCompletionSource<TResult> {
    private var _id : UUID
    private let _notificationName : Notification.Name
    
    private var _isCompleted = false
    private var _isCanceled = false
    
    private var _result: TResult?
    
    init() {
        _id = UUID()
        _notificationName = Notification.Name("\(_id.uuidString)_taskCompletionNotification")
    }
    
    func waitForCompletion() async -> TResult? {
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
    
    func setResult(_ result: TResult) {
        if _isCompleted || _isCanceled {
            return
        }
        
        _result = result
        _isCompleted = true
        
        NotificationCenter.default.post(name: _notificationName, object: nil)
    }
    
    func cancel() {
        if _isCompleted || _isCanceled {
            return
        }
        
        _isCanceled = true
        
        NotificationCenter.default.post(name: _notificationName, object: nil)
    }
}
