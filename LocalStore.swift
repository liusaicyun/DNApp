//
//  LocalStore.swift
//  DNApp
//
//  Created by SaiCyun Liu on 2016-02-16.
//  Copyright © 2016年 SaiCyun Liu. All rights reserved.
//

import UIKit

struct LocalStore {
	static let userDefaults = NSUserDefaults.standardUserDefaults()		//NSUserDefaults.standardUserDefaults.Object 是用来存储用户数据的，其实最好是存储配置信息。
	
	static func saveToken(token: String) {
		userDefaults.setObject(token, forKey: "tokenKey")
	}
	
	static func getToken() -> String? {
		return userDefaults.stringForKey("tokenKey")
	}
	
	static func deleteToken() {
		userDefaults.removeObjectForKey("tokenKey")
	}
	
	static func saveUpvotedStory(storyId: Int) {
		appendId(storyId, toKey: "upvotedStoriesKey")
	}
	
	static func saveUpvotedComment(commentId: Int) {
		appendId(commentId, toKey: "upvotedCommentsKey")
	}
	
	static func isStoryUpvoted(storyId: Int) -> Bool {
		return arrayForKey("upvotedStoriesKey", containsId: storyId)
	}
	
	static func isCommentUpvoted(commentId: Int) -> Bool {
		return arrayForKey("upvotedCommentsKey", containsId: commentId)
	}
	
	// MARK: Helper
	
	private static func arrayForKey(key: String, containsId id: Int) -> Bool {
		let elements = userDefaults.arrayForKey(key) as? [Int] ?? []
		return elements.contains(id)
	}
	
	private static func appendId(id: Int, toKey key: String) {		// toKey 外部参数名是给外部调用的, key 是内部参数名
		let elements = userDefaults.arrayForKey(key) as? [Int] ?? []	// 读取optional(array)类型的数据, 如果有，则将数据成员转化成 Int 类型，如果无，则为空数组，并赋值给 element
		if !elements.contains(id) {												// 如果本次的 storyId 不在 elements 里，则把这个 storyId 加到 elements 里面
			userDefaults.setObject(elements + [id], forKey: key)	// 每当有新的数组添加进来时，给予加到数组的后面，这个数组的索引
		}
	}
}