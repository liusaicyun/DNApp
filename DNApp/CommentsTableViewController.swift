//
//  CommentsTableViewController.swift
//  DNApp
//
//  Created by SaiCyun Liu on 2016-02-03.
//  Copyright © 2016年 SaiCyun Liu. All rights reserved.
//

import UIKit

class CommentsTableViewController: UITableViewController {

	var story:    JSON!
	var comments: JSON!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.estimatedRowHeight = 140
		tableView.rowHeight          = UITableViewAutomaticDimension
		
		comments = story["comments"]
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return comments.count + 1
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("StoryCell") as! StoryTableViewCell
		cell.configureWithStory(story)
		return cell
	}
	
}