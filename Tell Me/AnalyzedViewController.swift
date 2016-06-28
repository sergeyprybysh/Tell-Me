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
    
    @IBOutlet weak var transcriptTextView: UITextView!
    //Temp varibles to store data
    var mTranscript: String?
    var mConfidence: Double?
    
    
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
            dispatch_async(dispatch_get_main_queue(), {
            //Will update data model here
            let transcript = data![Client.IBMResponseKeys.transcript] as! String
            let confidence = data![Client.IBMResponseKeys.confidence] as! Double
            self.mTranscript = transcript
            self.mConfidence = confidence
            self.refreshTextView()
            })
        }
    }
    
    func refreshTextView() {
        transcriptTextView.text = mTranscript!
    }
    
}
