//
//  RouteTableViewController.swift
//  KeLiBiao
//
//  Created by Guo Chen on 2/19/17.
//  Copyright © 2017 Guo Chen. All rights reserved.
//

import UIKit

class RouteTableViewController: UITableViewController {
	
	var routes = [Route]() {
		didSet {
			tableView.reloadData()
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return routes.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "RouteCell", for: indexPath)
		if let routeCell = cell as? RouteCell {
			routeCell.route = routes[indexPath.row]
			return routeCell
		}
		return cell
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let identifier = segue.identifier {
			switch identifier {
			case "ShowStationTable":
				if let viewController = segue.destination as? StationTableViewController, let route = (sender as? RouteCell)?.route {
					Request.searchStationList(routeId: route.id, verificationCode: route.verificationCode) { response in
						if let response = response {
							viewController.stations = Parser.parseStationList(response)
							viewController.title = "\(route.name)，\(route.originStation)-\(route.terminalStation)，\(route.kilometeage)KM"
						}
					}
				}
			default: break
			}
		}
	}
	
}
