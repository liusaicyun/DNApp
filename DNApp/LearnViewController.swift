//
//  LearnViewController.swift
//  DNApp
//
//  Created by SaiCyun Liu on 2016-01-31.
//  Copyright © 2016年 SaiCyun Liu. All rights reserved.
//

import UIKit

class LearnViewController: UIViewController {

	@IBOutlet weak var dialogView: DesignableView!
	@IBOutlet weak var bookImageView: SpringImageView!

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(true)

	}

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(true)

		dialogView.animate()
	}
	@IBAction func learnButtonDidTouch(sender: AnyObject) {
		bookImageView.animation = "pop"
		bookImageView.animate()
	}
	@IBAction func closeButtonDidTouch(sender: AnyObject) {
		dialogView.animation = "fall"
		dialogView.animateNext{
			self.dismissViewControllerAnimated(true, completion: nil)
		}
	}
	
}
