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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        recordingLabel.hidden = true
        analyzeButton.hidden = true
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
        let recordingName = "recordedAudio.wav"
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
        
        let activityIndicator = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        //performSegueWithIdentifier("toAnalyzedVCSegue", sender: audioRecorder.url)
        
        Client.sharedInstance().getAudioTranscript(audioRecorder.url) { (data, error) -> Void in
            guard error == nil else {
                dispatch_async(dispatch_get_main_queue(), {
                    self.presentAlertWithErrorMessage(error!.localizedDescription)})
                return
            }
            dispatch_async(dispatch_get_main_queue(), {
                //Will update data model here
                let transcript = data![Client.IBMResponseKeys.transcript] as! String
                let confidence = data![Client.IBMResponseKeys.confidence] as! Double
            })
        }

        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toAnalyzedVCSegue" {
            let analyzedVC = segue.destinationViewController as! AnalyzedViewController
            let recordedAudioURL = sender as! NSURL
            analyzedVC.recordedAudioURL = recordedAudioURL
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
            let message = "There was an error while saving recorded aoudio"
            print(message)
            presentAlertWithErrorMessage(message)
        }
    }
    
}

extension UIViewController {
    
    func presentAlertWithErrorMessage(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}

