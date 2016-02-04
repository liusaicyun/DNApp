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
		
		comments = story["comments"]
		
		tableView.estimatedRowHeight = 140
		tableView.rowHeight          = UITableViewAutomaticDimension
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return comments.count + 1
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifer      = indexPath.row == 0 ? "StoryCell" : "CommentCell"
        let cell           = tableView.dequeueReusableCellWithIdentifier(identifer)! as UITableViewCell

        if let storyCell   = cell as? StoryTableViewCell {
			storyCell.configureWithStory(story)
		}

        if let commentCell = cell as? CommentTableViewCell {
        let comment        = comments[indexPath.row - 1]//indexPath如果有n个，那么，0 是 StoryCell，1 到 n - 1 都是 comment，所以 字典的 0 对应 indexPath（cell序列） 里面的 1，所以需要 indexPath - 1。
			commentCell.configureWithComment(comment)
		}
		
		return cell
	}
	
}