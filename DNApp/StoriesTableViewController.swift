//
//  StoriesTableViewController.swift
//  DNApp
//
//  Created by SaiCyun Liu on 2016-01-31.
//  Copyright © 2016年 SaiCyun Liu. All rights reserved.
//

import UIKit

class StoriesTableViewController: UITableViewController {

	@IBAction func menuButtonDidTouch(sender: AnyObject) {
		performSegueWithIdentifier("MenuSegue", sender: self)
	}
	
	@IBAction func loginButtonDidTouch(sender: AnyObject) {
		performSegueWithIdentifier("LoginSegue", sender: self)
	}
	
}
