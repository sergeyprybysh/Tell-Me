//
//  AnalyzedViewController.swift
//  Tell Me
//
//  Created by Sergey Prybysh on 6/5/16.
//  Copyright © 2016 Spryby. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class AnalyzedViewController: UIViewController {
    
    var recordedAudioURL: NSURL!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(recordedAudioURL)
        getTranscriptForAudio()
    }
    
    
    func getTranscriptForAudio() {
        Client.sharedInstance().getAudioTranscript(recordedAudioURL) { (data, error) -> Void in
            guard error == nil else {
                dispatch_async(dispatch_get_main_queue(), {
                self.presentAlertWithErrorMessage(error!.localizedDescription)})
                return
            }
        }
    }
    
    @IBAction func tapPlayButton(sender: AnyObject) {
        print("Tap play button")
    }
}
