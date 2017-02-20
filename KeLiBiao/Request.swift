//
//  Request.swift
//  KeLiBiao
//
//  Created by Guo Chen on 2/19/17.
//  Copyright © 2017 Guo Chen. All rights reserved.
//

import Foundation
import Alamofire

enum SearchType: Int {
	case byStation = 0
	case byRoute = 1
}

class Request {
	
	static var udid: String?
	static var activationCode: String?
	
	static func checkActivation(_ failureHandler: @escaping () -> Void = { _ in }) {
		if let udid = udid {
			Alamofire.request("http://trs.xd8.cn/route/checkdevice/0/\(udid)".encodeForUrl).validate().responseString { response in
				switch response.result {
				case .success(let value):
					let startIndex = value.startIndex
					let endIndex = value.index(startIndex, offsetBy: 8)
					let code = value.replacingCharacters(in: startIndex ..< endIndex, with: "")
					if code != "none" {
						activationCode = code
					} else {
						failureHandler()
					}
				case .failure: failureHandler()
				}
			}
		} else {
			udid = UIDevice.current.identifierForVendor?.uuidString
			failureHandler()
		}
	}
	
	static func registerDevice(activationCode code: String, _ completionHandler: @escaping (Bool) -> Void = { _ in }) {
		if let udid = udid {
			Alamofire.request("http://trs.xd8.cn/route/checkdevice/1/\(udid)/\(code)".encodeForUrl).validate().responseString { response in
				switch response.result {
				case .success(let value):
					let startIndex = value.startIndex
					let endIndex = value.index(startIndex, offsetBy: 8)
					let code = value.replacingCharacters(in: startIndex ..< endIndex, with: "")
					if code != "none" {
						activationCode = code
						completionHandler(true)
					} else {
						completionHandler(false)
					}
				case .failure: completionHandler(false)
				}
			}
		} else {
			udid = UIDevice.current.identifierForVendor?.uuidString
			completionHandler(false)
		}
	}
	
	static func searchRouteList(searchText: String, searchType: SearchType, _ completionHandler: @escaping (String?) -> Void = { _ in }) {
		if let udid = udid, let activationCode = activationCode {
			Alamofire.request("http://trs.xd8.cn/route/getroutelist/\(searchText)/\(searchType.rawValue)/\(udid)/\(activationCode)".encodeForUrl).validate().responseString { response in
				switch response.result {
				case .success(let value):
					if value != "none" {
						completionHandler(value)
					} else {
						completionHandler(nil)
					}
				case .failure: completionHandler(nil)
				}
			}
		} else {
			completionHandler(nil)
		}
	}
	
	static func searchStationList(routeId: String, verificationCode: String, _ completionHandler: @escaping (String?) -> Void = { _ in }) {
		if let udid = udid, let activationCode = activationCode {
			Alamofire.request("http://trs.xd8.cn/route/getklb/\(routeId)/\(verificationCode)/\(udid)/\(activationCode)".encodeForUrl).validate().responseString { response in
				switch response.result {
				case .success(let value): completionHandler(value)
				case .failure: completionHandler(nil)
				}
			}
		} else {
			completionHandler(nil)
		}
	}
	
}

extension String {
	
	fileprivate var encodeForUrl: String {
		return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
	}
	
}
