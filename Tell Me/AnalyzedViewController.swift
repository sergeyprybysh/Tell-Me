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
    
    var textObject: TextObject!
    
    @IBOutlet weak var transcriptTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshTextView()
    }
    
    
    @IBAction func pressAnalyzeButton(sender: UIButton) {
        analyzeTextWithIBM()
    }
    
    private func analyzeTextWithIBM() {
            Client.sharedInstance().analyzeText(textObject.text) { (emotionTone, languageTone, socialTone, error) -> Void in
                
                guard error == nil else {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.presentAlertWithErrorMessage(error!.localizedDescription)})
                    return
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    if let emotionT = emotionTone {

                    }
                    if let languageT = languageTone {

                    }
                    if let socialT = socialTone {

                    }
                })
            }
        
    }
    
    func refreshTextView() {
        transcriptTextView.text = textObject.text
    }
    
}
