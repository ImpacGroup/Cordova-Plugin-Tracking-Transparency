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
        
        if #available(iOS 14, *) {
            if (IMPTrackingManager.shared.trackingAvailable) {
                print("Tracking ist aktiv")
            } else if (IMPTrackingManager.shared.canRequestTracking) {
                
                let url = Bundle.main.url(forResource: "info", withExtension: "json")
                let jsonString = try! String.init(contentsOf: url!)
                let decoder = JSONDecoder()
                let info = try! decoder.decode(TrackingRequestInfo.self, from: jsonString.data(using: String.Encoding.utf8)!)
                
                IMPTrackingManager.shared.requestTracking(completion:  { status in
                    print(status)
                }, info: info)
            } else {
                print("Tracking can not requested")
            }
        } else {
            print("No ATT")
        }
    }


}

