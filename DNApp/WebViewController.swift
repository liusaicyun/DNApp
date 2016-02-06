//
//  WebViewController.swift
//  DNApp
//
//  Created by SaiCyun Liu on 2016-01-31.
//  Copyright © 2016年 SaiCyun Liu. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {

	@IBOutlet weak var webView: UIWebView!
	var url: String!
	@IBOutlet weak var progressView: UIProgressView!
	var hasFinishedLoading = false
	
	@IBAction func closeButtonDidTouch(sender: AnyObject) {
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	
	override func viewDidLoad() {
		self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
		super.viewDidLoad()
		let targetURL = NSURL(string: url)!
		let request = NSURLRequest(URL: targetURL)
		webView.loadRequest(request)
		webView.delegate = self
	}
	
//	override func preferredStatusBarStyle() -> UIStatusBarStyle {
//		return UIStatusBarStyle.LightContent
//	}
	override func prefersStatusBarHidden() -> Bool {
		return true
	}
//	override func setNeedsStatusBarAppearanceUpdate() {
//	}
	
	func webViewDidStartLoad(webView: UIWebView) {
		hasFinishedLoading = false
		updateProgress()
	}
	func webViewDidFinishLoad(webView: UIWebView) {
		delay(1) { [weak self] in
			if let _self = self {
				_self.hasFinishedLoading = true
			}
		}
	}
	
	func updateProgress() {
		if progressView.progress >= 1 {
			progressView.hidden = true
		} else {
			
			if hasFinishedLoading {
				progressView.progress += 0.002
			} else {
				if progressView.progress <= 0.3 {
					progressView.progress += 0.004
				} else if progressView.progress <= 0.6 {
					progressView.progress += 0.002
				} else if progressView.progress <= 0.9 {
					progressView.progress += 0.001
				} else if progressView.progress <= 0.94 {
					progressView.progress += 0.0001
				} else {
					progressView.progress = 0.9401
				}
			}
			
			delay(0.008) { [weak self] in
				if let _self = self {
					_self.updateProgress()
				}
			}
		}
	}

}
