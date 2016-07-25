//
//  DescriptionViewController.swift
//  Tell Me
//
//  Created by Sergey Prybysh on 7/20/16.
//  Copyright © 2016 Spryby. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var index: Int!
    
    var tone: [String]?
    var toneDescription: [String]?
    var level: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        setDataAtIndex(index)
        tableView.reloadData()
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
