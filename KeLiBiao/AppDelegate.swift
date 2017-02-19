//
//  AppDelegate.swift
//  KeLiBiao
//
//  Created by Guo Chen on 2/18/17.
//  Copyright © 2017 Guo Chen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		Request.udid = UIDevice.current.identifierForVendor?.uuidString
		return true
	}

}

