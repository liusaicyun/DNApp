//
//  MenuViewController.swift
//  DNApp
//
//  Created by SaiCyun Liu on 2016-01-31.
//  Copyright © 2016年 SaiCyun Liu. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

	@IBOutlet weak var dialogView: DesignableView!
	@IBAction func closeButtonDidTouch(sender: AnyObject) {
		dismissViewControllerAnimated(true, completion: nil)
		
		dialogView.animation = "fale"
		dialogView.animate()
	}

}
