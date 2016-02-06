//
//  NavigationViewController.swift
//  DNApp
//
//  Created by SaiCyun Liu on 2016-02-06.
//  Copyright © 2016年 SaiCyun Liu. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {
	
		override func preferredStatusBarStyle() -> UIStatusBarStyle {
			return UIStatusBarStyle.LightContent
		}

    override func viewDidLoad() {
        super.viewDidLoad()
		

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
