//
//  StudentTableViewCell.swift
//  Office Hours App
//
//  Created by Mark Kelsey on 2015-11-30.
//  Copyright © 2015 Mark Kelsey. All rights reserved.
//

import UIKit
import Parse

class StudentTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var problemLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
