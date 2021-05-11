//
//  ViewController.swift
//  Cordova Tracking Transparency
//
//  Created by Felix Nievelstein on 10.05.21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private var manager: IMPTrackingManager = IMPTrackingManager()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (manager.trackingAvailable) {
            print("Tracking ist aktiv")
        } else if (manager.canRequestTracking) {
            
            let reasons: [TrackingRequestReason] = [
                TrackingRequestReason(text: "Special offers and promotions just for you", image: UIImage.init(systemName: "heart.fill")!),
                TrackingRequestReason(text: "Advertisements that match your interests", image: UIImage.init(systemName: "circle.circle")!),
                TrackingRequestReason(text: "An improved personalized experience over time", image: UIImage.init(systemName: "circle.circle")!)
            ]
            let info = TrackingRequestInfo(
                primaryColor: UIColor.systemGreen,
                secondaryColor: UIColor.white,
                onPrimaryColor: UIColor.white,
                onSecondaryColor: UIColor.systemGreen,
                title: "Allow tracking on the next screen for:",
                reasons: reasons,
                subText: "You can change this option later in the Settings app.",
                buttonTitle: "Next"
            )
            
            manager.requestTracking(completion:  { status in
                print(status)
            }, info: info)
        } else {
            print("Tracking can not requested")
        }
    }


}

