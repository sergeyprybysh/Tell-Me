//
//  MessagesListViewController.swift
//  Tell Me
//
//  Created by Prybysh, Siarhei (ETW) on 7/26/16.
//  Copyright © 2016 Spryby. All rights reserved.
//

import UIKit
import CoreData

class MessagesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var messageArray = [TextObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View did load appear Table View")
        navigationItem.title = AppConstants.savedMessages
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        print("View will appear Table View")
        if let messages = fetchMessages() {
            if messages.isEmpty {
                emptyStateSetUp()
            }
            else {
                tableView.backgroundView = nil
                messageArray = messages
                tableView.reloadData()
            }
        }
        else {
            print("It's broken")
        }
    }
    
    private func emptyStateSetUp() {
        let emptyStateLabel = UILabel(frame: tableView.frame)
        emptyStateLabel.numberOfLines = 2
        emptyStateLabel.textAlignment = .Center
        emptyStateLabel.textColor = UIColor.grayColor()
        emptyStateLabel.text = AppConstants.emptyTableView
        tableView.backgroundView = emptyStateLabel
    }
    
    var sharedContext: NSManagedObjectContext {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }
    
    func fetchMessages() -> [TextObject]? {
        print("Fetching messages")
        let fetchRequest = NSFetchRequest(entityName: "TextObject")
        do {
            return try sharedContext.executeFetchRequest(fetchRequest) as? [TextObject]
        }
        catch _ {
            return nil
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: MessagesTableCell = tableView.dequeueReusableCellWithIdentifier("messagesCell") as! MessagesTableCell
        let textObject = messageArray[indexPath.row]
        cell.name.text = textObject.name
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Tap Tap")
    }
    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 150
//    }

}

