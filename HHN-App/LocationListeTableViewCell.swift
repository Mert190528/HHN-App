//
//  LocationListeTableViewCell.swift
//  HHN-App
//
//  Created by Mert Sürü on 30.06.17.
//  Copyright © 2017 Mert Sürü. All rights reserved.
//

import UIKit

class LocationListeTableViewCell: UITableViewCell {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var navigationButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
