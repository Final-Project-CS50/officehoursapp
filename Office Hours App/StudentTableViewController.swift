//
//  StudentTableViewController.swift
//  Office Hours App
//
//  Created by Mark Kelsey on 2015-12-03.
//  Copyright © 2015 Mark Kelsey. All rights reserved.
//

import UIKit
import Parse


class StudentTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var students = [Student]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        
        navigationItem.leftBarButtonItem = editButtonItem()
        
        loadCloudStudents()
        
    }

    
    func loadCloudStudents(){
                let query = PFQuery(className:"Student")
                query.findObjectsInBackgroundWithBlock {
                    (objects: [PFObject]?, error: NSError?) -> Void in
                        if error == nil {
                            // The find succeeded.
                           
                            // Do something with the found objects
                            if let object = objects {
                                for o in object {
                                    let name = o.objectForKey("name") as! String
                                    let problem = o.objectForKey("problem") as! String
                                    let timestamp = o.objectForKey("timeStamp") as! String
                                    let id = o.objectId!
                                    let tmp_student = Student(name: name, problem: problem, timestamp: timestamp)!
                                    tmp_student.id = id
                                    self.students += [tmp_student]
                                }
                            }
                            dispatch_async(dispatch_get_main_queue()) {
                                self.tableView.reloadData()
                            }
                            
                        } else {
                            // Log details of the failure
                            print("Error: \(error!) \(error!.userInfo)")
                            }
                        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  students.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "StudentTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! StudentTableViewCell

        // Fetches the appropriate student for the data source layout.
        let student = students[indexPath.row]
        cell.nameLabel.text = student.name
        cell.problemLabel.text = student.problem
        cell.timestampLabel.text = student.timestamp
        cell.objectID = student.id
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! StudentTableViewCell
            students.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)

            // Add the student the the Parse "Cloud"
            let query = PFQuery(className: "Student")
            query.whereKey("problem", equalTo: cell.problemLabel.text!)
            query.whereKey("timeStamp", equalTo: cell.timestampLabel.text!)
            query.findObjectsInBackgroundWithBlock {
                (objects: [PFObject]?, error: NSError?) -> Void in
                for object in objects! {
                    object.deleteEventually()
                }
            }
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    @IBAction func unwindToStudentList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? StudentViewController, student = sourceViewController.student {
            // Add a new student.
            let newIndexPath = NSIndexPath(forRow: students.count, inSection: 0)
            students.append(student)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        }
    }

}
