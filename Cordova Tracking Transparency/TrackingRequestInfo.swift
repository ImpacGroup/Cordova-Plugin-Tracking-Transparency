//
//  TrackingRequestInfo.swift
//  Cordova Tracking Transparency
//
//  Created by Felix Nievelstein on 11.05.21.
//

import UIKit

struct TrackingRequestInfo {
    /**
     Hex value of the background color
     */
    let primaryColor: UIColor
    let secondaryColor: UIColor
    let onPrimaryColor: UIColor
    let onSecondaryColor: UIColor
    let title: String
    let reasons: [TrackingRequestReason]
    let subText: String
    let buttonTitle: String
}

struct TrackingRequestReason {
    let text: String
    let image: UIImage
}
