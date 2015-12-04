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
    var problem: String
    var id: String!
    var timestamp: String
    
    // MARK: Initialization
    
    init?(name: String, problem: String, timestamp: String){
    
        // Initialize stored properties.
        self.name = name
        self.problem = problem
        self.timestamp = timestamp
        
        // Initialization should fail if there is no name.
        if name.isEmpty || problem.isEmpty || timestamp.isEmpty {
            return nil
        }
        
    }
}
