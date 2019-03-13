//
//  ViewController.swift
//  Sample-CoreData
//
//  Created by Ronaldo GomesJr on 12/08/2015.
//  Copyright © 2015 Technophile IT. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView:UITableView!
    
    var data:[NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "User")
        
        do {
            let fetchResults = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
            
            if let result = fetchResults {
                self.data = result
                self.tableView.reloadData()
            }
            
        }
        catch {
            print("")
        }
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        let user = self.data[indexPath.row] as NSManagedObject
        
        cell.textLabel?.text = user.valueForKey("name") as? String
        cell.detailTextLabel?.text = user.valueForKey("email") as? String
        
        return cell
    }
    
}

