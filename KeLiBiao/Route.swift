//
//  Route.swift
//  KeLiBiao
//
//  Created by Guo Chen on 2/19/17.
//  Copyright © 2017 Guo Chen. All rights reserved.
//

import Foundation

struct Route {
	
	let name: String
	let originStation: String
	let terminalStation: String
	let kilometeage: String
	let id: String
	let verificationCode: String
	
	var description: String {
		return "\(type(of: self)): [名称: \(name), 起站: \(originStation), 止站: \(terminalStation), 里程: \(kilometeage), id: \(id), 验证码: \(verificationCode)]"
	}
	
}
