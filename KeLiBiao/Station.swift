//
//  Station.swift
//  KeLiBiao
//
//  Created by Guo Chen on 2/19/17.
//  Copyright © 2017 Guo Chen. All rights reserved.
//

import Foundation

struct Station {
	
	let name: String
	let limit: String
	let mark: String
	let kilometeage: String
	let telegraphCode: String
	let tmisCode: String
	let railwayBureau: String
	
	var description: String {
		return "\(type(of: self)): [名称: \(name), 限制: \(limit), 接算标识: \(mark), 里程: \(kilometeage), 电报码: \(telegraphCode), TMIS码: \(tmisCode), 路局: \(railwayBureau)]"
	}

}
