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
import Charts
import CoreData
import MessageUI

class AnalyzedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {
    
    
    @IBOutlet weak var tableViews: UITableView!
    @IBOutlet weak var transcriptTextView: UITextView!
    
    var textObject: TextObject!
    
    var emotions: EmotionsTone?
    var language: LanguageTone?
    var social: SocialTone?
    
    var hasData = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        tableViews.delegate = self
        refreshTextView()
        fetchResults()
        tableViews.reloadData()
    }
    
    func setUpNavigationBar() {
        
        let saveImage = UIImage(named: "save")!
        let sendImage   = UIImage(named: "send")!
        
        let saveButton   = UIBarButtonItem(image: saveImage,  style: .Plain, target: self, action: #selector(AnalyzedViewController.tapSaveButton))
        let sendButton = UIBarButtonItem(image: sendImage,  style: .Plain, target: self, action: #selector(AnalyzedViewController.tapSendButton))
        
        navigationItem.rightBarButtonItems = [sendButton, saveButton]
    }
    
    var sharedContext: NSManagedObjectContext {
        return CoreDataStackManager.sharedInstance().managedObjectContext
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
                        let emTone = EmotionsTone(emotions: emotionT, context: self.sharedContext)
                        emTone.textObject = self.textObject
                    }
                    if let languageT = languageTone {
                        let langTone = LanguageTone(language: languageT, context: self.sharedContext)
                        langTone.textObject = self.textObject
                    }
                    if let socialT = socialTone {
                        let sTone = SocialTone(social: socialT, context: self.sharedContext)
                        sTone.textObject = self.textObject
                    }
                    CoreDataStackManager.sharedInstance().saveContext()
                    self.fetchResults()
                    self.tableViews.reloadData()
                })
            }
        
    }
    
    func tapSaveButton() {
        print("Tap Save Button")
        let alert = UIAlertController(title: "Save Message", message: "Enter name for message", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func tapSendButton() {
        let mailComposeVC = configureMailComposeVC("Sergey is a cool guy")
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeVC,animated: true, completion: nil)
        }
        else {
            presentAlertWithErrorMessage("Cannot send sessage at this time")
        }
    }
    
    func configureMailComposeVC(message: String) -> MFMailComposeViewController {
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setMessageBody(message, isHTML: false)
        return mailComposeVC
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        switch result.rawValue {
        case MFMailComposeResultCancelled.rawValue:
            print("Cancelled")
        case MFMailComposeResultSent.rawValue:
            print("Send")
        default:
            break
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func refreshTextView() {
        transcriptTextView.text = textObject.text
    }
    
    //MARK: implement UITableViewDelegate methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Emotions"
        case 1:
            return "Language"
        case 2:
            return "Social"
        default:
            return nil
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: ChartTableCell = tableView.dequeueReusableCellWithIdentifier("chartCell") as! ChartTableCell
        let finalCell = configureCell(cell, indexPath: indexPath.section)
        return finalCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("toDescriptionVCSegue", sender: indexPath.section)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toDescriptionVCSegue" {
            let descriptionVC = segue.destinationViewController as! DescriptionViewController
            let index = sender as! Int
            descriptionVC.index = index
            let backItem = UIBarButtonItem()
            backItem.title = AppConstants.navigationBackButton
            navigationItem.backBarButtonItem = backItem
        }
    }
    
    private func configureCell(cell: ChartTableCell, indexPath: Int) -> ChartTableCell {
        
        var dataValue: [BarChartDataEntry] = []

        switch indexPath {
        case 0:
            if let emotionsItem = emotions {
            dataValue.append(BarChartDataEntry(value: emotionsItem.anger, xIndex: 0))
            dataValue.append(BarChartDataEntry(value: emotionsItem.disgust, xIndex: 1))
            dataValue.append(BarChartDataEntry(value: emotionsItem.fear, xIndex: 2))
            dataValue.append(BarChartDataEntry(value: emotionsItem.joy, xIndex: 3))
            dataValue.append(BarChartDataEntry(value: emotionsItem.sadness, xIndex: 4))
            let chartData = BarChartDataSet(yVals: dataValue, label: "Emotions Tone Level")
            let chart = BarChartData(xVals: emotionsItem.chartStrings, dataSet: chartData)
            cell.chartView.data = chart
            }
        case 1:
            if let languageItem = language {
            dataValue.append(BarChartDataEntry(value: languageItem.analytical, xIndex: 0))
            dataValue.append(BarChartDataEntry(value: languageItem.confident, xIndex: 1))
            dataValue.append(BarChartDataEntry(value: languageItem.tentative, xIndex: 2))
            let chartData = BarChartDataSet(yVals: dataValue, label: "Language Tone Level")
            let chart = BarChartData(xVals: languageItem.chartStrings, dataSet: chartData)
            cell.chartView.data = chart
            }
        case 2:
            if let socialItem = social {
            dataValue.append(BarChartDataEntry(value: socialItem.openness, xIndex: 0))
            dataValue.append(BarChartDataEntry(value: socialItem.conscientiousness, xIndex: 1))
            dataValue.append(BarChartDataEntry(value: socialItem.extraversion, xIndex: 2))
            dataValue.append(BarChartDataEntry(value: socialItem.agreeableness, xIndex: 3))
            dataValue.append(BarChartDataEntry(value: socialItem.emotionalRange, xIndex: 4))
            let chartData = BarChartDataSet(yVals: dataValue, label: "Social Tone Level")
            let chart = BarChartData(xVals: socialItem.chartStrings, dataSet: chartData)
            cell.chartView.data = chart
            }
        default:
            break
        }
        
        return cell
    }
    
    
    func fetchResults() {
        if let emotionsResults = fetchEmotionsTone() {
            if !emotionsResults.isEmpty {
                emotions = emotionsResults[0]
                hasData = true
            }
        }
        
        if let languageResults = fetchLanguageTone() {
            if !languageResults.isEmpty {
                language = languageResults[0]
                hasData = true
            }
        }
        
        if let socialResults = fetchSocialTone() {
            if !socialResults.isEmpty {
                social = socialResults[0]
                hasData = true
            }
        }
    }
    
    func fetchEmotionsTone() -> [EmotionsTone]? {
        
        let fetchRequest = NSFetchRequest(entityName: "EmotionsTone")
        fetchRequest.sortDescriptors = []
        fetchRequest.predicate = NSPredicate(format: "textObject == %@", self.textObject)
        do {
            return try sharedContext.executeFetchRequest(fetchRequest) as? [EmotionsTone]
        }
        catch _ {
            return nil
        }
    }
    
    func fetchLanguageTone() -> [LanguageTone]? {
        
        let fetchRequest = NSFetchRequest(entityName: "LanguageTone")
        fetchRequest.sortDescriptors = []
        fetchRequest.predicate = NSPredicate(format: "textObject == %@", self.textObject)
        do {
            return try sharedContext.executeFetchRequest(fetchRequest) as? [LanguageTone]
        }
        catch _ {
            return nil
        }
    }
    
    func fetchSocialTone() -> [SocialTone]? {
        
        let fetchRequest = NSFetchRequest(entityName: "SocialTone")
        fetchRequest.sortDescriptors = []
        fetchRequest.predicate = NSPredicate(format: "textObject == %@", self.textObject)
        do {
            return try sharedContext.executeFetchRequest(fetchRequest) as? [SocialTone]
        }
        catch _ {
            return nil
        }
    }
    
    
    
}

