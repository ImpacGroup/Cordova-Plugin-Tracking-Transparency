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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (IMPTrackingManager.trackingAvailable) {
            print("Tracking ist aktiv")
        } else if (IMPTrackingManager.canRequestTracking) {
            IMPTrackingManager.requestTracking { status in
                print(status)
            }
        } else {
            print("Tracking can not requested")
        }
    }


}

