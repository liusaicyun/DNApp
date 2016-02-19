//
//  CommentsTableViewController.swift
//  DNApp
//
//  Created by SaiCyun Liu on 2016-02-03.
//  Copyright © 2016年 SaiCyun Liu. All rights reserved.
//

import UIKit

class CommentsTableViewController: UITableViewController, CommentTableViewCellDelegate, StoryTableViewCellDelegate,ReplyViewControllerDelegate {

	var story:    JSON!		//应该是从 StoriesTableViewController 里面传过来的，在 prepareForSegue 函数里，已经给 CommentsTableViewController（toView）的 sotry 赋值，所以这里的声明只是方便将数据传进来
	var comments: JSON!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		comments						= story["comments"]
		print(comments)
		tableView.estimatedRowHeight	= 140
		tableView.rowHeight				= UITableViewAutomaticDimension
		
		refreshControl?.addTarget(self, action: "relaodStory", forControlEvents: UIControlEvents.ValueChanged)
	}
	
	func relaodStory() {
		view.showLoading()
		DNService.storyForId(story["id"].int!, responseclose: { (JSON) -> () in
			self.view.hideLoading()
			self.story = JSON["story"]
			self.comments = JSON["story"]["comments"]
			self.tableView.reloadData()
			self.refreshControl?.endRefreshing()
		})
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return comments.count + 1
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {	// 这个函数的意思是用户触碰到了某个 cell 里面的对象时，执行函数内代码
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
		} 
		
		return cell
	}
	
	// MARK: CommentTableViewControllerDelegate
	
	func commentTableViewCellDidTouchUpvote	(cell: CommentTableViewCell) {	// 本函数，判断用户是否登录，如未，谈登录，如果已经登录了，识别用户点击的 commentId ，并将这个 commentupvote 发送给 designernews。并在本地记录下来，触发view变更
		if	let token		= LocalStore.getToken() {						// 识别是否登录
			let indexPath	= tableView.indexPathForCell(cell)!				// 获取点击的cell
			let comment		= comments[indexPath.row - 1]					// 获取cell的comment数据
			let commentId	= comment["id"].int!							// 获取commentid数据
			DNService.upvoteCommentWithId(commentId, token: token, responseclose: { (successful) -> () in //提交 upvote 到服务端
				
			})
			LocalStore.saveUpvotedComment	(commentId)						// 本地保存数据
			cell.configureWithComment		(comment)						// 触发view变更
		} else {
			performSegueWithIdentifier("LoginSegue", sender: self)
		}
	}
	
	func commentTableViewCellDidTouchComment(cell: CommentTableViewCell) {
		if LocalStore.getToken() == nil {
			performSegueWithIdentifier("LoginSegue", sender: self)
		} else {
			performSegueWithIdentifier("ReplySegue", sender: cell)			//  We need to send to cell information, otherwise there’s no way to tell what to reply to.
		}
	}
	
	// MARK: StoryTableViewCellDelegate
	
	func storyTableViewCellDidTouchUpvote	(cell: StoryTableViewCell, sender: AnyObject) {
		if	let token		= LocalStore.getToken() {
			let indexPath	= tableView.indexPathForCell(cell)				// 因为 commentspage 里面 只有一个 story 所以 indexPath 似乎没有什么必要
			let storyId		= story["id"].int!
				DNService.upvoteStoryWithId	(storyId, token: token, responseclose: { (successful) -> () in
			})
				LocalStore.saveUpvotedStory	(storyId)
				cell.configureWithStory		(story)
		} else {
			performSegueWithIdentifier("LoginSegue", sender: self)
		}
	}
	
	func storyTableViewCellDidTouchComment	(cell: StoryTableViewCell, sender: AnyObject) {
		if LocalStore.getToken() == nil {
			performSegueWithIdentifier("LoginSegue", sender: self)
		} else {
			performSegueWithIdentifier("ReplySegue", sender: cell)			//  We need to send to cell information, otherwise there’s no way to tell what to reply to.
		}
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {		// 这里的sender输入源是 performSegueWithIdentifier("ReplySegue", sender: cell)	中的 cell
		if segue.identifier == "ReplySegue" {
			let		toView = segue.destinationViewController as! ReplyViewController
			
			if	let	cell			= sender as? CommentTableViewCell {
				let indexPath		= tableView.indexPathForCell(cell)!
				let comment			= comments[indexPath.row - 1]
					toView.comment	= comment
			}
			
			if let	cell			= sender as? StoryTableViewCell {
					toView.story	= story
			}
			toView.delegate = self  // 意思是由 CommentsTableViewController 作为 toView 的代理方 是否在每个有代理关系的对象中，都需要声明（赋值）
		}
	}
	
	// MARK: ReplyViewControllerDelegate
	
	func replyViewControllerDidSend(controller: ReplyViewController) {
		relaodStory()
	}
	
	
	// Helper
	func flattenComments(comments: [JSON]) -> [JSON] {
		let flattenedComments = comments.map(commentsForComment).reduce([], combine: +)
		return flattenedComments
	}
	
	func commentsForComment(comment: JSON) -> [JSON] {
		let comments = comment["comments"].array ?? []
		return comments.reduce([comment]) { acc, x in
			acc + self.commentsForComment(x)
		}
	}
}