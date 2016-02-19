//
//  DNService.swift
//  DNApp
//
//  Created by SaiCyun Liu on 2016-02-06.
//  Copyright © 2016年 SaiCyun Liu. All rights reserved.
//

import Alamofire

struct DNService {
	
	private static let baseURL		= "https://www.designernews.co"
	private static let clientID		= "750ab22aac78be1c6d4bbe584f0e3477064f646720f327c5464bc127100a1a6d"
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
			case .Login:					return "/oauth/token"
			case .Stories:					return "/api/v1/stories"
			case .StoryId		(let id):	return "/api/v1/stories/\(id)"
			case .StoryUpvote	(let id):	return "/api/v1/stories/\(id)/upvote"
			case .StoryReply	(let id):	return "/api/v1/stories/\(id)/reply"
			case .CommentUpvote	(let id):	return "/api/v1/comments/\(id)/upvote"
			case .CommentReply	(let id):	return "/api/v1/comments/\(id)/reply"
			}
		}
	}
	
	static func storiesForSection(section: String, page: Int, responseclose: (JSON) -> ()) { //根据三个参数获取 stories，section、page、response，其中response需要在闭包中获得。storiesForSection 函数的 response 参数也是 Alamofire.request 里面的参数
		let urlString = baseURL + ResourcePath.Stories.description + "/" + section
		let parameters = [
			"page":			String(page),
			"client_id":	clientID
			]
		Alamofire.request(.GET, urlString, parameters: parameters)
			.responseJSON { response in
				let stories = JSON(response.result.value!)
				responseclose(stories) 			//这个就是闭包参数。现在只是声明了而已。在 loadStories 里面闭包参数有做操作。在这里做了一个映射。就是把 stories 映射到 JSON 对应的变量中。目的似乎是为了使得 storiesForSection 能够直接跟 Alamofire.request 的参数做关联。因为数据由 stoires 提供。
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
	
	static func storyForId(storyId: Int, responseclose: (JSON) -> ()) {
		let urlString = baseURL + ResourcePath.StoryId(storyId: storyId).description
		let parameters = [
		"client_id": clientID
		]
		Alamofire.request(.GET, urlString, parameters: parameters).responseJSON {
			response in
			let story = JSON(response.data ?? [])
			responseclose(story)
		}
	}
	
	static func loginWithEmail(email: String, password: String, responseString: (token: String?) -> ()) {
        let urlString  = baseURL + ResourcePath.Login.description
        let parameters = [
			"grant_type":		"password",
			"username":			email,
			"password":			password,
			"client_id":		clientID,
			"client_secret":	clientSecret
		]
		Alamofire.request(.POST, urlString, parameters: parameters).responseJSON {
			response in
            let json  = JSON(response.result.value!)
            let token = json["access_token"].string!
				responseString(token: token)
		}
	}
	
	static func upvoteStoryWithId			(storyID: Int,		token: String, responseclose: (successful: Bool) -> ()) {
		let urlString = baseURL + ResourcePath.StoryUpvote(storyId: storyID).description
			upvoteWithUrlString(urlString, token: token, responseclose: responseclose)
	}
	
	static func upvoteCommentWithId			(commentId: Int,	token: String, responseclose: (successful: Bool) -> ()) {
		let urlString = baseURL + ResourcePath.CommentUpvote(commentId: commentId).description
			upvoteWithUrlString(urlString, token: token, responseclose: responseclose)
	}
	
	private static func upvoteWithUrlString	(urlString: String, token: String, responseclose: (successful: Bool) -> ()) {
		let request				= NSMutableURLRequest(URL: NSURL(string: urlString)!)
			request.HTTPMethod	= "POST"
			request.setValue("Bearer \(token)", forHTTPHeaderField:"Authorization" )
		
		Alamofire.request(request).responseJSON { response in
			let successful = response.response?.statusCode == 200
				responseclose(successful: successful)
		}
	}
	
	static func replyStoryWithId(storyId: Int, token: String, body: String, reponseclose: (successful: Bool) -> ()) {
		let urlString = baseURL + ResourcePath.StoryReply(storyId: storyId).description
		replyWithUrlString(urlString, token: token, body: body, responseclose: reponseclose)
	}
	
	static func replyCommentWithId(commentId: Int, token: String, body: String, responseclose: (successful: Bool) -> ()) {
		let urlString = baseURL + ResourcePath.CommentReply(commentId: commentId).description
		replyWithUrlString(urlString, token: token, body: body, responseclose: responseclose)
	}
	
	private static func replyWithUrlString(urlString: String, token: String, body: String, responseclose: (successful: Bool) -> ()) {
		let request = NSMutableURLRequest(URL: NSURL(string: urlString)!)
			request.HTTPMethod = "POST"
			request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
			request.HTTPBody = "comment[body] = \(body)".dataUsingEncoding(NSUTF8StringEncoding)
		
		Alamofire.request(request).responseJSON { (response) -> Void in
			let json = JSON(response.data!)
			if let comment = json["comment"].string {
				responseclose(successful: true)
			} else {
				responseclose(successful: false)
			}
		}
	}
}



















