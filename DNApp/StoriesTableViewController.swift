//
//  StoriesTableViewController.swift
//  DNApp
//
//  Created by SaiCyun Liu on 2016-01-31.
//  Copyright © 2016年 SaiCyun Liu. All rights reserved.
//

import UIKit



class StoriesTableViewController: UITableViewController,StoryTableViewCellDelegate {
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
		return data.count
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell { //获取第几个cell cellForRowAtIndexPath，这个函数是否是在映射 cell 的时候发生？而且必然会发生？ 网友的解释是获得某一行的对象，这一行的数据从 return 来
		let cell                   = tableView.dequeueReusableCellWithIdentifier("StoryCell") as! StoryTableViewCell  //在载入 StoriesTableViewController 的时候将执行一下操作，声明 StoryCell 可重用，并赋值给 cell 变量
		let story = data[indexPath.row]		//story 其实是字典类型，将数据源赋值给 字典型 story
		cell.configureWithStory(story)		//对 story 的数据进行加工，并映射到 cell
        cell.delegate              = self// self 指的是实例化的 StoriesTableViewController ，在这里是 StoryBoard 里的那个 UITableViewController ，由它来代理 cell 的请求。（也就是执行那两个函数）
		return cell
	}
	// Mark:
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		performSegueWithIdentifier("WebSegue", sender: self)
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
	}
	
	//MARK: StoryTableViewCellDelegate
	
	func storyTableViewCellDidTouchUpvote(cell: StoryTableViewCell, sender: AnyObject) {
		//TODO: Implenment Upvote
	}
	
	func storyTableViewCellDidTouchComment(cell: StoryTableViewCell, sender: AnyObject) {
		performSegueWithIdentifier("CommentsSegue", sender: self)
	}
	
}