//
//  SimpleCompletionSource.swift
//  Pods-SwiftCompletionSource_Example
//
//  Created by Amir on 05.04.2025.
//

public class SimpleCompletionSource {
    private var _id : UUID
    private let _notificationName : Notification.Name
    
    private var _isCompleted = false
    
    init() {
        _id = UUID()
        _notificationName = Notification.Name("\(_id.uuidString)_taskCompletionNotification")
    }
    
    func WaitForCompletion() async {
        for await _ in NotificationCenter.default.notifications(named: _notificationName) {
            if _isCompleted {
                break
            }
        }
    }
    
    func SetResult() {
        if _isCompleted {
            return
        }
        
        _isCompleted = true
        NotificationCenter.default.post(name: _notificationName, object: nil)
    }
}
