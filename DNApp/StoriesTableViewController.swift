//
//  StoriesTableViewController.swift
//  DNApp
//
//  Created by SaiCyun Liu on 2016-01-31.
//  Copyright © 2016年 SaiCyun Liu. All rights reserved.
//

import UIKit



class StoriesTableViewController: UITableViewController,StoryTableViewCellDelegate, MenuViewControllerDelegate {
	
	
	let transitionManager = TransitionManager()
	var stories: JSON! = []
	var isFirstTime = true
	
	func loadStories(section: String, page: Int) {		// loadStories 其实是要获得一个 变量名为 stories 的 JSON 对象。
		print("loadStories 载入了")
		DNService.storiesForSection(section, page: page) { (getJSON) -> () in
			print("hello")
			self.stories = getJSON["stories"]
			self.tableView.reloadData()
			self.view.hideLoading()
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		print("viewDidLoad")	
		tableView.estimatedRowHeight = 100
		tableView.rowHeight          = UITableViewAutomaticDimension
		loadStories("", page: 1)
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(true)
		print("viewDidAppear")
		if isFirstTime {
			view.showLoading()
			isFirstTime = false
		}
	}
	
	

	@IBAction func menuButtonDidTouch(sender: AnyObject) {
		performSegueWithIdentifier("MenuSegue", sender: self)
	}
	
	@IBAction func loginButtonDidTouch(sender: AnyObject) {
		performSegueWithIdentifier("LoginSegue", sender: self)
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return stories.count
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell { //获取第几个cell cellForRowAtIndexPath，这个函数是否是在映射 cell 的时候发生？而且必然会发生？ 网友的解释是获得某一行的对象，这一行的数据从 return 来。   updata: 在这个函数里，其实在运行的时候（初始化 tableViewController 的时候，执行这个函数。这时候我们获得了当前这个 Cell 的 NSIndexPath 对象（其实是传入进来的），根据这个对象的 row 属性，就可以返回正确的 Cell 实例。
        let cell      = tableView.dequeueReusableCellWithIdentifier("StoryCell") as! StoryTableViewCell		//在载入 StoriesTableViewController 的时候将执行一下操作，声明 StoryCell 可重用，并赋值给 cell 变量
        let story     = stories[indexPath.row]//story 其实是字典类型，将数据源赋值给 字典型 story
		cell.configureWithStory(story)		//对 story 的数据进行加工，并映射到 cell
        cell.delegate = self// self 指的是实例化的 StoriesTableViewController ，在这里是 StoryBoard 里的那个 UITableViewController ，由它来代理 cell 的请求。（也就是执行那两个函数）
		return cell
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		performSegueWithIdentifier("WebSegue", sender: indexPath)
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
	}
	
	//MARK: MenuViewControllerDelegate
	
	func menuViewControllerDidTouchTop(controller: MenuViewController) {
		view.showLoading()
		loadStories("", page: 1)
		navigationItem.title = "Top Stories"
		
	}
	
	func menuViewControllerDidTouchRecent(controller: MenuViewController) {
		view.showLoading()
		loadStories("recent", page: 1)
		navigationItem.title = "Recent Stories"
		
	}
	
	
	//MARK: StoryTableViewCellDelegate
	
	func storyTableViewCellDidTouchUpvote(cell: StoryTableViewCell, sender: AnyObject) {
		//TODO: Implenment Upvote
	}
	
	func storyTableViewCellDidTouchComment(cell: StoryTableViewCell, sender: AnyObject) {
		performSegueWithIdentifier("CommentsSegue", sender: cell)				// 当用户触碰 Comment 按钮时，调用 Comment是Segue，并将 cell 发出去
	}
	
	// MARk: Misc
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "CommentsSegue" {
            let toView    = segue.destinationViewController as! CommentsTableViewController
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)!//获取 tableView 里 sender 这个 cell，这个函数是 给个 Cell，返回 IndexPath。这里得到了 Cell 实例的indexPath（通过 sender 传过来）
            toView.story  = stories[indexPath.row] //这里就是提前给 CommentsTableViewController 准备的数据
		}
		if segue.identifier == "WebSegue" {
			let toView = segue.destinationViewController as! WebViewController
			let indexPath = sender as! NSIndexPath
			let url = stories[indexPath.row]["url"].string!
			toView.url = url
			toView.transitioningDelegate = transitionManager
		}
		if segue.identifier == "MenuSegue" {
			let toView = segue.destinationViewController as! MenuViewController
			toView.delegate = self	// self 指的是实例化的 StoiresTableViewContorller，由实例化的 这个Contorller 来代理 MenuViewController 的请求。
		}
	}
	
}