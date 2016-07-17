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

class AnalyzedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableViews: UITableView!
    @IBOutlet weak var transcriptTextView: UITextView!
    
    var textObject: TextObject!
    
    var emotions: EmotionsTone?
    var language: LanguageTone?
    var social: SocialTone?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViews.delegate = self
        refreshTextView()
        tableViews.reloadData()
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
                        _ = EmotionsTone(emotions: emotionT, context: self.sharedContext)
                    }
                    if let languageT = languageTone {
                        _ = LanguageTone(language: languageT, context: self.sharedContext)
                    }
                    if let socialT = socialTone {
                        _ = SocialTone(social: socialT, context: self.sharedContext)
                    }
                    CoreDataStackManager.sharedInstance().saveContext()
                })
            }
        
    }
    
    
    func refreshTextView() {
        transcriptTextView.text = textObject.text
    }
    
    //MARK: implement UITableViewDelegate methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: ChartTableCell = tableView.dequeueReusableCellWithIdentifier("chartCell") as! ChartTableCell
        let finalCell = configureCell(cell, indexPath: indexPath.row)
        return finalCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        presentAlertWithErrorMessage("Alert\(indexPath.row)")
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }
    
    
    private func configureCell(cell: ChartTableCell, indexPath: Int) -> ChartTableCell {
        
        var dataValue: [BarChartDataEntry] = []

        switch indexPath {
        case 0:
            dataValue.append(BarChartDataEntry(value: emotions!.anger, xIndex: 0))
            dataValue.append(BarChartDataEntry(value: emotions!.disgust, xIndex: 1))
            dataValue.append(BarChartDataEntry(value: emotions!.fear, xIndex: 2))
            dataValue.append(BarChartDataEntry(value: emotions!.joy, xIndex: 3))
            dataValue.append(BarChartDataEntry(value: emotions!.sadness, xIndex: 4))
            let chartData = BarChartDataSet(yVals: dataValue, label: "Emotions Tone Level")
            let chart = BarChartData(xVals: emotions!.chartStrings, dataSet: chartData)
            cell.chartView.data = chart
            break
        case 1:
            dataValue.append(BarChartDataEntry(value: language!.analytical, xIndex: 0))
            dataValue.append(BarChartDataEntry(value: language!.confident, xIndex: 1))
            dataValue.append(BarChartDataEntry(value: language!.tentative, xIndex: 2))
            let chartData = BarChartDataSet(yVals: dataValue, label: "Language Tone Level")
            let chart = BarChartData(xVals: language!.chartStrings, dataSet: chartData)
            cell.chartView.data = chart
            break
        case 2:
            dataValue.append(BarChartDataEntry(value: social!.openness, xIndex: 0))
            dataValue.append(BarChartDataEntry(value: social!.conscientiousness, xIndex: 1))
            dataValue.append(BarChartDataEntry(value: social!.extraversion, xIndex: 2))
            dataValue.append(BarChartDataEntry(value: social!.agreeableness, xIndex: 3))
            dataValue.append(BarChartDataEntry(value: social!.emotionalRange, xIndex: 4))
            let chartData = BarChartDataSet(yVals: dataValue, label: "Social Tone Level")
            let chart = BarChartData(xVals: social!.chartStrings, dataSet: chartData)
            cell.chartView.data = chart
            break
        default:
            break
        }
        
        return cell
    }
    
}
