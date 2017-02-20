//
//  RouteCell.swift
//  KeLiBiao
//
//  Created by Guo Chen on 2/19/17.
//  Copyright © 2017 Guo Chen. All rights reserved.
//

import UIKit

class RouteCell: UITableViewCell {
	
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var originStationLabel: UILabel!
	@IBOutlet weak var teminalStationLabel: UILabel!
	@IBOutlet weak var kilometeageLabel: UILabel!
		
	var route: Route? {
		didSet{
			nameLabel.text = route?.name
			originStationLabel.text = route?.originStation
			teminalStationLabel.text = route?.terminalStation
			kilometeageLabel.text = route?.kilometeage
		}
	}

}
