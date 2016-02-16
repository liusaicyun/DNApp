//
//  CommentsTableViewController.swift
//  DNApp
//
//  Created by SaiCyun Liu on 2016-02-03.
//  Copyright © 2016年 SaiCyun Liu. All rights reserved.
//

import UIKit

class CommentsTableViewController: UITableViewController, CommentTableViewCellDelegate, StoryTableViewCellDelegate {

	var story:    JSON!		//应该是从 StoriesTableViewController 里面传过来的，在 prepareForSegue 函数里，已经给 CommentsTableViewController（toView）的 sotry 赋值，所以这里的声明只是方便将数据传进来
	var comments: JSON!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		comments						= story["comments"]
		tableView.estimatedRowHeight	= 140
		tableView.rowHeight				= UITableViewAutomaticDimension
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return comments.count + 1
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
			let	identifer				= indexPath.row == 0 ? "StoryCell" : "CommentCell"
			let	cell					= tableView.dequeueReusableCellWithIdentifier(identifer)! as UITableViewCell

        if	let	storyCell				= cell as? StoryTableViewCell {
				storyCell.configureWithStory(story)
				storyCell.delegate		= self
		}

        if	let commentCell				= cell as? CommentTableViewCell {
			let comment					= comments[indexPath.row - 1]//indexPath如果有n个，那么，0 是 StoryCell，1 到 n - 1 都是 comment，所以 字典的 0 对应 indexPath（cell序列） 里面的 1，所以需要 indexPath - 1。
				commentCell.configureWithComment(comment)
				commentCell.delegate	= self
		} else {
			performSegueWithIdentifier("LoginSegue", sender: self)
		}
		
		return cell
	}
	
	// MARK: CommentTableViewControllerDelegate
	
	func commentTableViewCellDidTouchUpvote	(cell: CommentTableViewCell) {
		if	let token		= LocalStore.getToken() {
			let indexPath	= tableView.indexPathForCell(cell)!
			let comment		= comments[indexPath.row - 1]
			let commentId	= comment["id"].int!
			DNService.upvoteCommentWithId(commentId, token: token, responseclose: { (successful) -> () in
				
			})
			LocalStore.saveUpvotedComment	(commentId)
			cell.configureWithComment		(comment)
		}
	}
	
	func commentTableViewCellDidTouchComment(cell: CommentTableViewCell) {
		
	}
	
	//MARK: StoryTableViewCellDelegate
	
	func storyTableViewCellDidTouchUpvote	(cell: StoryTableViewCell, sender: AnyObject) {
		if	let token = LocalStore.getToken() {
			let indexPath = tableView.indexPathForCell(cell)
			let storyId = story["id"].int!
			DNService.upvoteStoryWithId(storyId, token: token, responseclose: { (successful) -> () in
				
			})
			LocalStore.saveUpvotedStory(storyId)
			cell.configureWithStory(story)
		}
	}
	
	func storyTableViewCellDidTouchComment	(cell: StoryTableViewCell, sender: AnyObject) {
		
	}
	
}