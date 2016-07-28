//
//  DescriptionViewController.swift
//  Tell Me
//
//  Created by Sergey Prybysh on 7/20/16.
//  Copyright © 2016 Spryby. All rights reserved.
//

import UIKit
import Charts

class DescriptionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var chartView: BarChartView!
    var index: Int!
    var barData: BarChartData?
    
    var tone: [String]?
    var toneDescription: [String]?
    var level: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        if let data = barData {
            setUpCharts(data)
        }
        setDataAtIndex(index)
        tableView.reloadData()
    }
    
    private func setUpCharts(data: BarChartData) {
        chartView.data = data
        chartView.descriptionText = ""
        chartView.rightAxis.drawLabelsEnabled = false
        chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        let highValue = ChartLimitLine(limit: 0.75, label: "High Value")
        highValue.lineColor = NSUIColor.orangeColor()
        highValue.lineWidth = 1
        highValue.valueTextColor = NSUIColor.orangeColor()
        highValue.valueFont = UIFont.systemFontOfSize(10)
        let lowValue = ChartLimitLine(limit: 0.25, label: "Low Value")
        lowValue.lineWidth = 1
        lowValue.valueTextColor = NSUIColor.redColor()
        lowValue.valueFont = UIFont.systemFontOfSize(10)
        chartView.rightAxis.addLimitLine(highValue)
        chartView.rightAxis.addLimitLine(lowValue)
    }
    
    private func setDataAtIndex(index: Int) {
        if index == 0 {
            tone = EmotionsDescription.tone
            toneDescription = EmotionsDescription.description
            level = EmotionsDescription.level
        }
        else if index == 1 {
            tone = LanguageDescription.tone
            toneDescription = LanguageDescription.description
            level = LanguageDescription.level
        }
        else if index == 2 {
            tone = SocialDescription.tone
            toneDescription = SocialDescription.description
            level = SocialDescription.level
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tone!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: DescriptionTableCell = tableView.dequeueReusableCellWithIdentifier("descriptionCell") as! DescriptionTableCell
        configureCell(cell, index: indexPath.row)
        return cell
    }
    
    func configureCell(cell: DescriptionTableCell, index: Int) -> DescriptionTableCell {
        cell.firstLabel.text = tone![index]
        cell.textView.text = toneDescription![index]
        cell.secondLabel.text = level![index]
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
}
