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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View did load appear Table View")
        navigationItem.title = AppConstants.savedMessages
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        print("View will appear Table View")
        fetchResults()
        if (fetchedResultsController.fetchedObjects?.count == 0) {
            emptyStateSetUp()
        }
    }
    
    private func emptyStateSetUp() {
        let emptyStateLabel = UILabel(frame: tableView.frame)
        emptyStateLabel.textAlignment = .Center
        emptyStateLabel.textColor = UIColor.grayColor()
        emptyStateLabel.text = "No records yet"
        tableView.backgroundView = emptyStateLabel
    }
    
    
    private func fetchResults() {
        do {
            try fetchedResultsController.performFetch()
        }
        catch {
            print(error)
        }
    }
    
    lazy var fetchedResultsController: NSFetchedResultsController = {
        
        let fetchRequest = NSFetchRequest(entityName: "TextObject")
        fetchRequest.sortDescriptors = []
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.sharedContext, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchedResultsController        
    }()
    
    
    var sharedContext: NSManagedObjectContext {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: MessagesTableCell = tableView.dequeueReusableCellWithIdentifier("messagesCell") as! MessagesTableCell
        let textObject = fetchedResultsController.objectAtIndexPath(indexPath) as! TextObject
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

