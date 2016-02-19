//
//  ReplyViewController.swift
//  DNApp
//
//  Created by SaiCyun Liu on 2016-02-17.
//  Copyright © 2016年 SaiCyun Liu. All rights reserved.
//

import UIKit

protocol ReplyViewControllerDelegate: class {
	func replyViewControllerDidSend(controller: ReplyViewController)
}

class ReplyViewController: UIViewController {

	var					story:			JSON = []
	var					comment:		JSON = []
	@IBOutlet weak var	replyTextView:	UITextView!
	weak var			delegate:		ReplyViewControllerDelegate?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		replyTextView.becomeFirstResponder()  //FirstResponder 有点像首个获得焦点的意思
	}

	@IBAction func sendButtonDidTouch(sender: AnyObject) {
		view.showLoading()
		let token = LocalStore.getToken()!
		let body = replyTextView.text
		
		if let storyId = story["id"].int {
			DNService.replyStoryWithId(storyId, token: token, body: body, reponseclose: { (successful) -> () in
				self.view.hideLoading()
				if successful {
					self.dismissViewControllerAnimated(true, completion: nil)
					self.delegate?.replyViewControllerDidSend(self)
				} else {
					self.showAlert()
				}
			})
		}
		
		if let commentId = comment["id"].int {
			DNService.replyStoryWithId(commentId, token: token, body: body, reponseclose: { (successful) -> () in
				self.view.hideLoading()
				if successful {
					self.dismissViewControllerAnimated(true, completion: nil)
					self.delegate?.replyViewControllerDidSend(self)
				} else {
					self.showAlert()
				}
			})
		}
	}
	func showAlert() {
		var alert = UIAlertController(title: "Oh noes", message: "Something went wrong. Your Message wasn't sent.", preferredStyle: UIAlertControllerStyle.Alert)
		alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
		self.presentViewController(alert, animated: true, completion: nil)	//updata：iOS 8 之后，UIAlertController 无需指定代理。  因为这里写在 ReplyViewController 里面，所以，里面 view 的操作可以直接由 ReplyViewController 代理。不需要写 protocol ？但是如果涉及到 其它自己写的 ViewController 就需要了。iOS中使用Delegate主要用于两个页面之间的数据传递。
	}
	
		
}
