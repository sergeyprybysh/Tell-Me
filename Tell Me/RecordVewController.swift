//
//  RecordVewController.swift
//  Tell Me
//
//  Created by Sergey Prybysh on 6/5/16.
//  Copyright © 2016 Spryby. All rights reserved.
//

import UIKit
import AVFoundation

class RecordVewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var analyzeButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordingLabel.hidden = true
        stopButton.hidden = true
        analyzeButton.hidden = true
        navigationItem.title = AppConstants.appName
    }


    @IBAction func tapRecordButton(sender: AnyObject) {
        
        print("Press record button")
        
        recordingLabel.hidden = false
        stopButton.hidden = false
        recordButton.enabled = false
        recordingLabel.text = AppConstants.recordingLabel
        analyzeButton.hidden = true
        
        recordAudio()
    }
    
    
    func recordAudio() {
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try!
            session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    
    @IBAction func tapStopButton(sender: AnyObject) {
        
        print("Press stop recording button")
        
        recordingLabel.text = AppConstants.analyzeLabel
        recordButton.enabled = true
        stopButton.hidden = true
        
        audioRecorder.stop()
        let session = AVAudioSession.sharedInstance()
        try! session.setActive(false)
    }
    
    
    @IBAction func tapAnalyzedButton(sender: AnyObject) {
        print("Press analyze button")
        performSegueWithIdentifier("toAnalyzedVCSegue", sender: nil)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {        
        if segue.identifier == "toAnalyzedVCSegue" {
            _ = segue.destinationViewController as! AnalyzedViewController
            let backItem = UIBarButtonItem()
            backItem.title = AppConstants.navigationBackButton
            navigationItem.backBarButtonItem = backItem
        }
    }
    
    
    //MARK: implement AVAudioRecorderDelegate methods
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        print("Audioecorder finished recording")
        
        if flag {
            print("Audio successfully saved")
            analyzeButton.hidden = false
        }
        else {
            print("There was an error while saving recorded aoudio")
        }
    }
    
}

