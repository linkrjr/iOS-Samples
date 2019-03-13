//
//  SettingsViewController.swift
//  Sample-CoreData
//
//  Created by Ronaldo GomesJr on 13/08/2015.
//  Copyright © 2015 Technophile IT. All rights reserved.
//

import UIKit
import CoreData

class SettingsViewController: UITableViewController {
    
    @IBOutlet weak var backupDatabaseCell: UITableViewCell!
    @IBOutlet weak var generateDataCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print("selected cell")
        
        let cell = self.tableView(tableView, cellForRowAtIndexPath: indexPath)
        
        switch cell  {
        case self.generateDataCell:
            self.generateData()
        default:
            print("default case")
        }
        
    }
    
    private func generateData() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        for _ in (0..<6) {
            let entity = NSEntityDescription.entityForName("User", inManagedObjectContext: managedContext)
            
            let user = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
            
            user.setValue("Ronaldo", forKey: "name")
            user.setValue("ronaldo@frontfoot.com.au", forKey: "email")
            
            do {
                try managedContext.save()
            }
            catch {
                print("error saving record")
                print(error)
            }
        }
        
    }
    
    
}
