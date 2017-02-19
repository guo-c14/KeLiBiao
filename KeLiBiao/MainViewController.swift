//
//  MainViewController.swift
//  KeLiBiao
//
//  Created by Guo Chen on 2/19/17.
//  Copyright © 2017 Guo Chen. All rights reserved.
//

import UIKit
import TextFieldEffects
import SwiftMessages

class MainViewController: UIViewController {
	
	@IBOutlet weak var searchTextField: HoshiTextField!
	
	@IBAction func tapBackGroundView(_ sender: UITapGestureRecognizer) {
		if sender.state == .ended {
			searchTextField.resignFirstResponder()
		}
		sender.cancelsTouchesInView = false
	}
	
	fileprivate let regex = try! NSRegularExpression(pattern: "^[\\u4e00-\\u9fa5a-zA-Z0-9]+$", options: [])
	
	override func viewDidLoad() {
		super.viewDidLoad()
		searchTextField.delegate = self
		Request.checkActivation { [weak weakSelf = self] in
			let alertController = UIAlertController(title: "请输入激活码", message: nil, preferredStyle: .alert)
			alertController.addTextField()
			alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
			alertController.addAction(UIAlertAction(title: "激活", style: .default) { alert in
				let code = ((alertController.textFields![0]) as UITextField).text ?? ""
				Request.registerDevice(activationCode: code) { isSuccess in
					if isSuccess {
						weakSelf?.showMessage(theme: .success, title: "激活成功", body: nil, duration: .forever)
					} else {
						weakSelf?.showMessage(theme: .error, title: "激活失败", body: nil, duration: .forever)
					}
				}
			})
			weakSelf?.present(alertController, animated: true, completion: nil)
		}
	}
	
	private func showMessage(theme: Theme, title: String?, body: String?, duration: SwiftMessages.Duration) {
		let messageView: MessageView = MessageView.viewFromNib(layout: .CardView)
		messageView.configureContent(title: title, body: body, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: nil, buttonTapHandler: { _ in SwiftMessages.hide() })
		messageView.configureTheme(theme, iconStyle: .light)
		messageView.configureDropShadow()
		messageView.button?.isHidden = true
		var config = SwiftMessages.Config()
		config.duration = duration
		config.dimMode = .gray(interactive: true)
		config.shouldAutorotate = true
		config.interactiveHide = true
		config.presentationContext = .window(windowLevel: UIWindowLevelStatusBar)
		SwiftMessages.show(config: config, view: messageView)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	
	}
	
}

extension MainViewController: UITextFieldDelegate {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		return textField.resignFirstResponder()
	}
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		if string == "" {
			return true
		}
		let rangeOfFirstMatch = regex.rangeOfFirstMatch(in: string, options: [], range: string.nsRange)
		return NSEqualRanges(string.nsRange, rangeOfFirstMatch)
	}
	
}

extension String {
	
	fileprivate var nsRange: NSRange {
		return NSRange(location: 0, length: utf16.count)
	}
	
}
