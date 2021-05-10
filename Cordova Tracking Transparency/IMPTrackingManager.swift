//
//  IMPTrackingManager.swift
//  Cordova Tracking Transparency
//
//  Created by Felix Nievelstein on 10.05.21.
//

import UIKit
import AppTrackingTransparency

class IMPTrackingManager {
    
    class var trackingStatus: ATTrackingManager.AuthorizationStatus {
        get {
            ATTrackingManager.trackingAuthorizationStatus
        }
    }
    
    class var trackingAvailable: Bool {
        get {
            return ATTrackingManager.trackingAuthorizationStatus == .authorized
        }
    }
    
    class var canRequestTracking: Bool {
        get {
            return ATTrackingManager.trackingAuthorizationStatus == .notDetermined
        }
    }
    
    class func requestTracking(completion: @escaping (Bool) -> ()) {
        ATTrackingManager.requestTrackingAuthorization { status in
            completion(trackingAvailable)
        }
    }
}
