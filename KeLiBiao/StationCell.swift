//
//  StationCell.swift
//  KeLiBiao
//
//  Created by Guo Chen on 2/19/17.
//  Copyright © 2017 Guo Chen. All rights reserved.
//

import UIKit

class StationCell: UITableViewCell {
	
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var kilometeageLabel: UILabel!
	@IBOutlet weak var limitLabel: UILabel!
	@IBOutlet weak var telegraphCodeLabel: UILabel!
	@IBOutlet weak var tmisCodeLabel: UILabel!
	@IBOutlet weak var railwayBureauLabel: UILabel!
	
	var station: Station? {
		didSet {
			nameLabel.text = station?.name
			kilometeageLabel.text = station?.kilometeage
			limitLabel.text = station?.limit
			telegraphCodeLabel.text = station?.telegraphCode
			tmisCodeLabel.text = station?.tmisCode
			railwayBureauLabel.text = station?.railwayBureau
			if station?.mark == "Y" {
				nameLabel.textColor = .red
			} else {
				nameLabel.textColor = kilometeageLabel.textColor
			}
		}
	}

}
