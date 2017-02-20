//
//  Parser.swift
//  KeLiBiao
//
//  Created by Guo Chen on 2/19/17.
//  Copyright © 2017 Guo Chen. All rights reserved.
//

import Foundation

class Parser {
	
	static func parseActivationCode(_ response: String) -> String {
		let startIndex = response.startIndex
		let endIndex = response.index(startIndex, offsetBy: 8)
		return response.replacingCharacters(in: startIndex ..< endIndex, with: "")
	}
	
	static func parseRouteList(_ response: String) -> [Route] {
		var routes = [Route]()
		let routeStrGroup = response.components(separatedBy: "||")
		for routeStr in routeStrGroup {
			let routeData = routeStr.components(separatedBy: "|")
			if routeData.count == 6 {
				let route = Route(name: routeData[0], originStation: routeData[1], terminalStation: routeData[2], kilometeage: routeData[3], id: routeData[4], verificationCode: routeData[5])
				routes.append(route)
			}
		}
		return routes
	}
	
	static func parseStationList(_ response: String) -> [Station] {
		var stations = [Station]()
		let stationStrGroup = response.components(separatedBy: "||")
		for stationStr in stationStrGroup {
			let stationData = stationStr.components(separatedBy: "|")
			if stationData.count == 7 {
				let station = Station(name: stationData[0], limit: stationData[1], mark: stationData[2], kilometeage: stationData[3], telegraphCode: stationData[4], tmisCode: stationData[5], railwayBureau: stationData[6])
				stations.append(station)
			}
		}
		return stations
	}
	
}
