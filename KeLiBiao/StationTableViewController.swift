//
//  StationTableViewController.swift
//  KeLiBiao
//
//  Created by Guo Chen on 2/19/17.
//  Copyright © 2017 Guo Chen. All rights reserved.
//

import UIKit

class StationTableViewController: UITableViewController {
	
	var stations = [Station]() {
		didSet {
			tableView.reloadData()
		}
	}

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StationCell", for: indexPath)
		if let stationCell = cell as? StationCell {
			stationCell.station = stations[indexPath.row]
			return stationCell
		}
        return cell
    }
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let viewController = navigationController?.viewControllers[1] as? RouteTableViewController {
			if let station = (tableView.cellForRow(at: indexPath) as? StationCell)?.station {
				Request.searchRouteList(searchText: station.telegraphCode, searchType: .byStation) { response in
					if let response = response {
						viewController.routes = Parser.parseRouteList(response)
						viewController.title = "线路"
					} else if let _ = viewController.navigationController {
						viewController.showMessage(theme: .warning, title: "没有查询到符合条件的数据！", body: nil, duration: .forever)
					}
					_ = viewController.navigationController?.popViewController(animated: true)
				}
			}
		}
	}

}
