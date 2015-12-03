//
//  ViewController.swift
//  Office Hours App
//
//  Created by Mark Kelsey on 2015-11-29.
//  Copyright © 2015 Mark Kelsey. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var studentName: UITextField!

    @IBOutlet weak var studentNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        studentName.delegate = self
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
        studentNameLabel.text = textField.text
    }
    
    // MARK: Actions
    
    @IBAction func setDefaultLabelText(sender: UIButton) {
        studentNameLabel.text = "Default Text"
    }
    

}

