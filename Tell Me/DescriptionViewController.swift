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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("descriptionCell") as! DescriptionTableCell
        return cell
    }
    
    func configureCell(cell: DescriptionTableCell, index: UInt) -> DescriptionTableCell {
        
        return cell
    }
    

}
