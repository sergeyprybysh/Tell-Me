//
//  RecordVewController.swift
//  Tell Me
//
//  Created by Sergey Prybysh on 6/5/16.
//  Copyright © 2016 Spryby. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class RecordVewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingImage: UIImageView!
    @IBOutlet weak var bottomLabel: UILabel!
    
    var audioRecorder: AVAudioRecorder!
    var isRecording = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopButton.hidden = true
        navigationItem.title = AppConstants.appName
        recordingImage.image = UIImage(named: "inprogress")
        recordingImage.hidden = true
        bottomLabel.hidden = true
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
    }
    
    func setUpStop() {
        stopButton.setImage(UIImage(named: "stop"), forState: UIControlState.Normal)
        stopButton.hidden = false
        bottomLabel.text = AppConstants.stop
        bottomLabel.hidden = false
    }
    
    func setUpGetTranscript() {
        stopButton.setImage(UIImage(named: "transcript"), forState: UIControlState.Normal)
        stopButton.hidden = false
        bottomLabel.text = AppConstants.transcript
        bottomLabel.hidden = false
    }
    
    var sharedContext: NSManagedObjectContext {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }


    @IBAction func tapRecordButton(sender: UIButton) {
        
        print("Press record button")
        
        recordingLabel.text = AppConstants.recordingLabel
        recordingImage.hidden = false
        recordButton.enabled = false
        setUpStop()
        isRecording = true
        
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
        if isRecording {
            
            print("Press stop recording button")
        
            audioRecorder.stop()
            let session = AVAudioSession.sharedInstance()
            try! session.setActive(false)
            
            isRecording = false
            recordingLabel.text = AppConstants.reRecord
            recordButton.enabled = true
            recordingImage.hidden = true
            setUpGetTranscript()
        }
        else {
            tapAnalyzedButton()
        }
    }
    
    
    func tapAnalyzedButton() {
        
        print("Press analyze button")
        
        let activityIndicator = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        
        Client.sharedInstance().getAudioTranscript(audioRecorder.url) { (data, error) -> Void in
            guard error == nil else {
                dispatch_async(dispatch_get_main_queue(), {
                    activityIndicator.stopAnimating()
                    self.presentAlertWithErrorMessage(error!.localizedDescription)})
                return
            }
            dispatch_async(dispatch_get_main_queue(), {
                activityIndicator.stopAnimating()
                let transcript = data![Client.IBMResponseKeys.transcript] as! String
                let confidence = data![Client.IBMResponseKeys.confidence] as! Double
                let textObject = TextObject(text: transcript, confidence: confidence, context: self.sharedContext)
                CoreDataStackManager.sharedInstance().saveContext()
                self.performSegueWithIdentifier("toAnalyzedVCSegue", sender: textObject)
            })
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toAnalyzedVCSegue" {
            let analyzedVC = segue.destinationViewController as! AnalyzedViewController
            let textObject = sender as! TextObject
            analyzedVC.textObject = textObject
            let backItem = UIBarButtonItem()
            backItem.title = AppConstants.navigationBackButton
            navigationItem.backBarButtonItem = backItem
        }
    }
    
    
    //MARK: implement AVAudioRecorderDelegate methods
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        print("Audiorecorder finished recording")
        
        if flag {
            print("Audio successfully saved")
        }
        else {
            let message = "There was an error while saving recorded audio"
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

