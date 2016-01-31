//
//  StoriesTableViewController.swift
//  DNApp
//
//  Created by SaiCyun Liu on 2016-01-31.
//  Copyright © 2016年 SaiCyun Liu. All rights reserved.
//

import UIKit

class StoriesTableViewController: UITableViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
//		UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
	func preferredStatusBarStyle()->UIStatusBarStyle{
			return UIStatusBarStyle.LightContent
		}
		tableView.estimatedRowHeight = 100
		tableView.rowHeight = UITableViewAutomaticDimension
	}

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
        let cell                   = tableView.dequeueReusableCellWithIdentifier("StoryCell") as! StoryTableViewCell
        cell.titleLabel.text       = "Learn iOS Design and Code"
        cell.badgeImageView.image  = UIImage(named: "badge-apple")
        cell.avatarImageView.image = UIImage(named: "content-avatar-default")
        cell.authorLabel.text      = "Meng To, designer and coder"
        cell.timeLabel.text        = "5m"
		cell.upvoteButton.setTitle("59", forState: UIControlState.Normal)
		cell.commentButton.setTitle("32", forState: UIControlState.Normal)
		
		return cell
	}
	// Mark:
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		performSegueWithIdentifier("WebSegue", sender: self)
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
	}
	
	
	
}