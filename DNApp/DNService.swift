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
	
	static func storiesForSection(section: String, page: Int, response: (JSON) -> ()) {
		let urlString = baseURL + ResourcePath.Stories.description + "/" + section
		let parameters = [
			"page": String(page),
			"client_id": clientID
			]
//		Alamofire.request(.GET, "https://httpbin.org/get", parameters: ["foo": "bar"])
//			.responseJSON{ response in
//				let stories = JSON(data ?? [])
//				response(stories)
//				print(response)
//		}
//		Alamofire.request(.GET, urlString, parameters: parameters).responseJSON() {
//			response in
//			guard let json = response.data else { return }
//			let stories = JSON(json)
//			print("JSON: \(stories)")
//		}
		Alamofire.request(.GET, urlString, parameters: parameters).responseJSON() {
			response in
			guard let resultAnyObject = response.result.value else { return }
			let resultJSON = JSON(resultAnyObject)
			let stories = resultJSON["stories"]
			print("result: \(response.request)")
			print("data:\(data)")
			print("stories: \(stories)")
		}
	}
}
