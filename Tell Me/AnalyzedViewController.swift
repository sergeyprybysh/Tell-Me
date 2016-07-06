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
            Client.sharedInstance().analyzeText(textObject.text, completionHandler: { (emotionTone, languageTone, socialTone, error) -> Void in
                if let emotionT = emotionTone {
                    print("THIS IS EMOTION")
                    print(emotionT)
                }
                if let languageT = languageTone {
                    print("THIS IS LANGUAGE")
                    print(languageT)
                }
                if let socialT = socialTone {
                    print("THIS IS SOCIAL")
                    print(socialT)
                }
            })
        
    }
    
    func refreshTextView() {
        transcriptTextView.text = textObject.text
    }
    
}
