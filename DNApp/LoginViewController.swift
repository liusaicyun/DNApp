//
//  LoginViewController.swift
//  DNApp
//
//  Created by SaiCyun Liu on 2016-01-30.
//  Copyright © 2016年 SaiCyun Liu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {

	@IBOutlet weak var dialogView: DesignableView!
	@IBOutlet weak var emailTextField: DesignableTextField!
	@IBOutlet weak var passwordTextField: DesignableTextField!
	@IBOutlet weak var emailImageView: SpringImageView!
	@IBOutlet weak var passwordImageView: SpringImageView!
	
	
	override func preferredStatusBarStyle() -> UIStatusBarStyle {
		return UIStatusBarStyle.LightContent
	}
	
	@IBAction func closeButtonDidTouch(sender: AnyObject) {
		dismissViewControllerAnimated(true, completion: nil)
	}

	@IBAction func loginButtonDidTouch(sender: AnyObject) {

		DNService.loginWithEmail(emailTextField.text!, password: passwordTextField.text!) { (token) -> () in
			if let token = token { // 意思是如果 token 有值，则...
			} else {
				self.dialogView.animation = "shake"
				self.dialogView.animate()
			}
		}
		
		
		
	}


	override func viewDidLoad() {
		super.viewDidLoad()
		emailTextField.delegate = self
		passwordTextField.delegate = self
	}
	
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		view.endEditing(true)
	}
	
	func textFieldDidBeginEditing(textField: UITextField) {
		if textField == emailTextField {	//如果 emailTextField 正在输入，则换图，执行动画。否则（没有在输入，就是常态的时候，或者输入的是 passwordTextField，icon恢复正常
			emailImageView.image = UIImage(named: "icon-mail-active")
			emailImageView.animate()
		} else {
			emailImageView.image = UIImage(named: "icon-mail")
		}
		
		if textField == passwordTextField {
			passwordImageView.image	= UIImage(named: "icon-password-active")
			passwordImageView.animate()
		} else {
			passwordImageView.image = UIImage(named: "icon-password")
		}
	}
	
	func textFieldDidEndEditing(textField: UITextField) {
		emailImageView.image = UIImage(named: "icon-mail")
		passwordImageView.image = UIImage(named:"icon-password")
	}
}
