//
//  Request.swift
//  KeLiBiao
//
//  Created by Guo Chen on 2/19/17.
//  Copyright © 2017 Guo Chen. All rights reserved.
//

import Foundation
import Alamofire

class Request {
	
	static var udid: String?
	static var activationCode: String?
	
	static func checkActivation(_ completionHandler: @escaping () -> Void = { _ in }) {
		if let udid = udid {
			Alamofire.request("http://trs.xd8.cn/route/checkdevice/0/\(udid)").validate().responseString { response in
				switch response.result {
				case .success(let value):
					let startIndex = value.startIndex
					let endIndex = value.index(startIndex, offsetBy: 8)
					let code = value.replacingCharacters(in: startIndex ..< endIndex, with: "")
					if code != "none" {
						activationCode = code
						return
					}
				case .failure: break
				}
				completionHandler()
			}
		} else {
			udid = UIDevice.current.identifierForVendor?.uuidString
			completionHandler()
		}
	}
	
	static func registerDevice(activationCode code: String, _ completionHandler: @escaping (Bool) -> Void = { _ in }) {
		if let udid = udid {
			Alamofire.request("http://trs.xd8.cn/route/checkdevice/1/\(udid)/\(code)").validate().responseString { response in
				switch response.result {
				case .success(let value):
					let startIndex = value.startIndex
					let endIndex = value.index(startIndex, offsetBy: 8)
					let code = value.replacingCharacters(in: startIndex ..< endIndex, with: "")
					if code != "none" {
						activationCode = code
						completionHandler(true)
						return
					}
				case .failure: break
				}
				completionHandler(false)
			}
		} else {
			udid = UIDevice.current.identifierForVendor?.uuidString
			completionHandler(false)
		}
	}
	
	static func search() {
		
	}
	
}
