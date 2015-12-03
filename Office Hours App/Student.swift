//
//  Student.swift
//  Office Hours App
//
//  Created by Mark Kelsey on 2015-12-03.
//  Copyright © 2015 Mark Kelsey. All rights reserved.
//

import UIKit

class Student {
    
    // MARK: Properties
    
    var name: String
    
    // MARK: Initialization
    
    init?(name: String){
    
        // Initialize stored properties.
        self.name = name
        
        // Initialization should fail if there is no name.
        if name.isEmpty {
            return nil
        }
        
    }
}
