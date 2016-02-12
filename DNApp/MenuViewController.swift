//
//  MenuViewController.swift
//  DNApp
//
//  Created by SaiCyun Liu on 2016-01-31.
//  Copyright © 2016年 SaiCyun Liu. All rights reserved.
//

import UIKit

protocol MenuViewControllerDelegate: class {
	func menuViewControllerDidTouchTop(controller: MenuViewController)
	func menuViewControllerDidTouchRecent(controller: MenuViewController)
	
}

class MenuViewController: UIViewController {

	@IBOutlet weak var dialogView: DesignableView!
	weak var delegate: MenuViewControllerDelegate?
	
	@IBAction func closeButtonDidTouch(sender: AnyObject) {
		dismissViewControllerAnimated(true, completion: nil)
		
		dialogView.animation = "fale"
		dialogView.animate()
	}

	@IBAction func topButtonDidTouch(sender: AnyObject) {
		delegate?.menuViewControllerDidTouchTop(self)
		closeButtonDidTouch(sender)
	}

	@IBAction func recentButtonDidTouch(sender: AnyObject) {
		delegate?.menuViewControllerDidTouchRecent(self)
		closeButtonDidTouch(sender)
	}
	@IBAction func loginButtonDidTouch(sender: AnyObject) {
		
	}
}
