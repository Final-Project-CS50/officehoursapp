//
//  StudentViewController.swift
//  Office Hours App
//
//  Created by Mark Kelsey on 2015-11-29.
//  Copyright © 2015 Mark Kelsey. All rights reserved.
//

import UIKit
import Parse

class StudentViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var studentName: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var studentProblem: UITextField!

    var student: Student?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        studentName.delegate = self
        
        let testObject = PFObject(className: "TestObject")
        testObject["foo"] = "bar"
        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("Object has been saved.")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }

    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        // Hide the keyboard.
        
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
    }
    
    // MARK: Navigation
    
    // Configure view controller.
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if submitButton === sender {
            let name = studentName.text ?? ""
            let problem = studentProblem.text ?? ""
            let currentDate = NSDate()
            let dateFormatter = NSDateFormatter()
            dateFormatter.locale = NSLocale.currentLocale()
            dateFormatter.dateFormat = "hh:mm"
            
            let webstudent = PFObject(className:"Student")
            webstudent["name"] = name
            webstudent["problem"] = problem
            webstudent["timeStamp"] = dateFormatter.stringFromDate(currentDate)
            webstudent.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    // The student has been saved.
                } else {
                    // There was a problem, check error.description
                }
            }
            student = Student(name: name, problem: problem, timestamp: webstudent["timeStamp"] as! String)
        }
    }

}

