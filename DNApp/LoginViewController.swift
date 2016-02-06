//
//  LoginViewController.swift
//  DNApp
//
//  Created by SaiCyun Liu on 2016-01-30.
//  Copyright © 2016年 SaiCyun Liu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
	
	override func preferredStatusBarStyle() -> UIStatusBarStyle {
		return UIStatusBarStyle.LightContent
	}

	@IBOutlet weak var dialogView: DesignableView!
	@IBAction func closeButtonDidTouch(sender: AnyObject) {
		dismissViewControllerAnimated(true, completion: nil)
	}

	@IBAction func loginButtonDidTouch(sender: AnyObject) {
        dialogView.animation = "shake"
		dialogView.animate()
	}


	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		view.endEditing(true)
	}
	
}
