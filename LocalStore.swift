//
//  LocalStore.swift
//  DNApp
//
//  Created by SaiCyun Liu on 2016-02-16.
//  Copyright © 2016年 SaiCyun Liu. All rights reserved.
//

import UIKit

struct LocalStore {
	static let userDefaults = NSUserDefaults.standardUserDefaults()
	
	static func saveToken(token: String) {
		userDefaults.setObject(token, forKey: "tokenKey")
	}
	
	static func getToken() -> String? {
		return userDefaults.stringForKey("tokenKey")
	}
	
	static func deleteToken() {
		userDefaults.removeObjectForKey("tokenKey")
	}
}
