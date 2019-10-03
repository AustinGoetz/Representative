//
//  RepresentativeTableViewCell.swift
//  Representative-master
//
//  Created by Austin Goetz on 10/2/19.
//  Copyright © 2019 DevMtnStudent. All rights reserved.
//

import UIKit

class RepresentativeTableViewCell: UITableViewCell {

    var representative: Representative? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var partyLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var districtLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    
    func updateViews() {
        nameLabel.text = representative?.name
        partyLabel.text = representative?.party
        websiteLabel.text = representative?.link
        districtLabel.text = representative?.district
        phoneNumberLabel.text = representative?.phone
    }
}
