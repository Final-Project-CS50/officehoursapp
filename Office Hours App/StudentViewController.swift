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

    
    /*
    This value is either passed by `MealTableViewController` in `prepareForSegue(_:sender:)`
    or constructed as part of adding a new meal.
    */
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
    
    // MARK: navigation
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if submitButton === sender {
            let name = studentName.text ?? ""
            let problem = studentProblem.text ?? ""
            
            // Set the meal to be passed to MealTableViewController after the unwind segue.
            student = Student(name: name, problem: problem)
            
            let webstudent = PFObject(className:"Student")
            webstudent["name"] = name
            webstudent["problem"] = problem
            webstudent.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    // The object has been saved.
                } else {
                    // There was a problem, check error.description
                }
            }
        }
    }
    
    // MARK: Actions
    

    

}

