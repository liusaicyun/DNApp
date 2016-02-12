//
//  DNService.swift
//  DNApp
//
//  Created by SaiCyun Liu on 2016-02-06.
//  Copyright © 2016年 SaiCyun Liu. All rights reserved.
//

import Alamofire

struct DNService {
	
	private static let baseURL = "https://www.designernews.co"
	private static let clientID = "750ab22aac78be1c6d4bbe584f0e3477064f646720f327c5464bc127100a1a6d"
	private static let clientSecret = "53e3822c49287190768e009a8f8e55d09041c5bf26d0ef982693f215c72d87da"

	private enum ResourcePath: CustomStringConvertible {
		case Login
		case Stories
		case StoryId(storyId: Int)
		case StoryUpvote(storyId: Int)
		case StoryReply(storyId: Int)
		case CommentUpvote(commentId: Int)
		case CommentReply(commentId: Int)
		
		var description: String {
			switch self {
			case .Login: return "/oauth/token"
			case .Stories: return "/api/v1/stories"
			case .StoryId(let id): return "/api/v1/stories/\(id)"
			case .StoryUpvote(let id): return "/api/v1/stories/\(id)/upvote"
			case .StoryReply(let id): return "/api/v1/stories/\(id)/reply"
			case .CommentUpvote(let id): return "/api/v1/comments/\(id)/upvote"
			case .CommentReply(let id): return "/api/v1/comments/\(id)/reply"
			}
		}
	}
	
	static func storiesForSection(section: String, page: Int, responseclose: (JSON) -> ()) { //根据三个参数获取 stories，section、page、response，其中response需要在闭包中获得。storiesForSection 函数的 response 参数也是 Alamofire.request 里面的参数
		let urlString = baseURL + ResourcePath.Stories.description + "/" + section
		let parameters = [
			"page": String(page),
			"client_id": clientID
			]
		Alamofire.request(.GET, urlString, parameters: parameters)
			.responseJSON { response in
				let stories = JSON(response.result.value!)
				responseclose(stories) 			//这个就是闭包参数。现在只是声明了而已。在 loadStories 里面闭包参数有做操作。在这里做了一个映射。就是把 stories 映射到 JSON 对应的变量中。
		}
//		Alamofire.request(.GET, urlString, parameters: parameters).responseJSON() {
//			response in
//			let stories = JSON(response.result.value ?? [])
//			print(stories)
//			let stories = data
//			let resultJSON = JSON(resultAnyObject)
//			let stories = resultJSON["stories"]
//			print("result: \(response.request)")
//			print("data:\(stories)")
//		}
	}
/*	static func storiesForSection(section: String, page: Int,re: (JSON) -> ()) {
		let urlString = baseURL + ResourcePath.Stories.description + "/" + section
		let parameters = [
			"page": String(page),
			"client_id": clientID
		]
		
		Alamofire.request(.GET, urlString, parameters: parameters).responseJSON() {
			data in
			let resuletJSON = JSON(data.result.value ?? [])
			print(data.result.value)
			print(resuletJSON)
			
			
		}
	}*/
}
