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
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("StoryCell") as! StoryTableViewCell
		cell.titleLabel.text = "Learn iOS Design and Code"
		cell.badgeImageView.image = UIImage(named: "badge-apple")
		cell.avatarImageView.image = UIImage(named: "content-avatar-default")
		
		return cell
	}
	// Mark:
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		performSegueWithIdentifier("WebSegue", sender: self)
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
	}
	
	
}