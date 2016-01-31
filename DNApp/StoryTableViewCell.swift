//
//  StoryTableViewCell.swift
//  DNApp
//
//  Created by SaiCyun Liu on 2016-01-31.
//  Copyright © 2016年 SaiCyun Liu. All rights reserved.
//

import UIKit

class StoryTableViewCell: UITableViewCell {

	@IBOutlet weak var badgeImageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var timeLabel: UILabel!
	@IBOutlet weak var avatarImageView: UIImageView!
	@IBOutlet weak var authorLabel: UILabel!
	@IBOutlet weak var upvoteButton: SpringButton!
	@IBOutlet weak var commentButton: SpringButton!
	
	@IBAction func upvoteButtonDidTouch(sender: AnyObject) {
        upvoteButton.animation = "pop"
        upvoteButton.force     = 3
		upvoteButton.animate()
	}
	
	@IBAction func commentButtonDidTouch(sender: AnyObject) {
        commentButton.animation = "pop"
        commentButton.force     = 3
		commentButton.animate()
	}
	

}
