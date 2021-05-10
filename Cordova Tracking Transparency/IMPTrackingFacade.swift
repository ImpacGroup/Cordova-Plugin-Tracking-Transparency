//
//  IMPTrackingFacade.swift
//  Cordova Tracking Transparency
//
//  Created by Felix Nievelstein on 10.05.21.
//

import Foundation
import Cordova

@objc (ImpacTracking) class IMPTrackingFacade: CDVPlugin {
    
    @objc(canRequestTracking:) func canRequestTracking(command: CDVInvokedUrlCommand) {
        let result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: IMPTrackingManager.canRequestTracking)
        self.commandDelegate.send(result, callbackId: command.callbackId)
    }
}
