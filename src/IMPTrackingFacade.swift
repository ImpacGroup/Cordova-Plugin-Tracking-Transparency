//
//  IMPTrackingFacade.swift
//  Cordova Tracking Transparency
//
//  Created by Felix Nievelstein on 10.05.21.
//

import Foundation
import Cordova

@objc (ImpacTracking) class IMPTrackingFacade: CDVPlugin {
    
    private var onRequestCallbackId: String?
    
    private var manager: IMPTrackingManager = IMPTrackingManager()
    
    @objc(canRequestTracking:) func canRequestTracking(command: CDVInvokedUrlCommand) {
        let result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: manager.canRequestTracking)
        self.commandDelegate.send(result, callbackId: command.callbackId)
    }
    
    @objc(trackingAvailable:) func trackingAvailable(command: CDVInvokedUrlCommand) {
        let result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: manager.trackingAvailable)
        self.commandDelegate.send(result, callbackId: command.callbackId)
    }
     
    @objc(requestTracking:) func requestTracking(command: CDVInvokedUrlCommand) {
        if onRequestCallbackId == nil {
            onRequestCallbackId = command.callbackId
            if command.arguments.count == 1, let infoJson = command.arguments[0] as? String  {
                do {
                    let decoder = JSONDecoder()
                    if let data = infoJson.data(using: String.Encoding.utf8) {
                        let info = try decoder.decode(TrackingRequestInfo.self, from: data)
                        manager.requestTracking(completion: requestCompletion, info: info)
                    } else {
                        manager.requestTracking(completion: requestCompletion)
                    }
                } catch {
                    print(error)
                    let result = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: error.localizedDescription)
                    self.commandDelegate.send(result, callbackId: command.callbackId)
                }
            } else {
                manager.requestTracking(completion: requestCompletion)
            }
        } else {
            let result = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "Request already Running")
            self.commandDelegate.send(result, callbackId: command.callbackId)
        }
    }
    
    private func requestCompletion(success: Bool) {
        if let callbackId = onRequestCallbackId {
            let result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: success)
            self.commandDelegate.send(result, callbackId: callbackId)
            onRequestCallbackId = nil
        }
    }
}