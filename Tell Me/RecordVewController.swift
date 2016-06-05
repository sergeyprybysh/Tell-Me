//
//  RecordVewController.swift
//  Tell Me
//
//  Created by Sergey Prybysh on 6/5/16.
//  Copyright © 2016 Spryby. All rights reserved.
//

import UIKit

class RecordVewController: UIViewController {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordingLabel.hidden = true
        stopButton.hidden = true
        navigationBar.
        
    }


    @IBAction func tapRecordButton(sender: AnyObject) {
        
        print("Press record button")
        recordingLabel.hidden = false
        stopButton.hidden = false
        recordButton.enabled = false
        recordingLabel.text = "Recording in progress"
    }
    
    
    @IBAction func tapStopButton(sender: AnyObject) {
        
        print("Press stop recording button")
        recordingLabel.text = "Analyze recorded audio"
        recordButton.enabled = true
        stopButton.hidden = true
    }
}

