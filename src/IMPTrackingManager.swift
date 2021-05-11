//
//  IMPTrackingManager.swift
//  Cordova Tracking Transparency
//
//  Created by Felix Nievelstein on 10.05.21.
//

import UIKit
import AppTrackingTransparency

class IMPTrackingManager: InfoViewControllerDelegate {
    
    var trackingStatus: ATTrackingManager.AuthorizationStatus {
        get {
            ATTrackingManager.trackingAuthorizationStatus
        }
    }
    
    var trackingAvailable: Bool {
        get {
            return ATTrackingManager.trackingAuthorizationStatus == .authorized
        }
    }
    
    var canRequestTracking: Bool {
        get {
            return ATTrackingManager.trackingAuthorizationStatus == .notDetermined
        }
    }
    
    var requestCompletion: ((Bool) -> ())? = nil
    var viewController: InfoViewController? = nil
        
    func requestTracking(completion: @escaping (Bool) -> (), info: TrackingRequestInfo? = nil) {
        if let mInfo = info, let rootVC = getCurrentViewController() {
            viewController = InfoViewController(info: mInfo, nibName: "InfoViewController", bundle: nil)
            viewController!.delegate = self
            requestCompletion = completion
            viewController!.modalPresentationStyle = .fullScreen
            rootVC.present(viewController!, animated: true, completion: nil)
        } else {
            ATTrackingManager.requestTrackingAuthorization {[weak self] status in
                guard let strongSelf = self else { return }
                completion(strongSelf.trackingAvailable)
            }
        }
    }
    
    func onButtonPressed() {
        ATTrackingManager.requestTrackingAuthorization {[weak self] status in
            guard let strongSelf = self else { return }
            if let mCompletion = strongSelf.requestCompletion {
                mCompletion(strongSelf.trackingAvailable)
            }
            strongSelf.requestCompletion = nil
            DispatchQueue.main.async {
                strongSelf.viewController?.dismiss(animated: true, completion: nil)
            }            
        }
    }
        
    
    private func getCurrentViewController() -> UIViewController? {
        var currentVC: UIViewController? = nil
        if let viewController = UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive}).map({$0 as? UIWindowScene}).compactMap({$0}).first?.windows.filter({$0.isKeyWindow}).first?.rootViewController {
            currentVC = viewController
            while currentVC?.presentedViewController != nil
            {
                currentVC = currentVC?.presentedViewController;
            }
        }
        return currentVC
    }
}
