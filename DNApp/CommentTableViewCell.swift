//
//  CommentTableViewCell.swift
//  DNApp
//
//  Created by SaiCyun Liu on 2016-02-04.
//  Copyright © 2016年 SaiCyun Liu. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
	@IBOutlet weak var avatarImageView: UIImageView!
	@IBOutlet weak var authorLabel: UILabel!
	@IBOutlet weak var timeLabel: UILabel!
	@IBOutlet weak var upvoteButton: SpringButton!
	@IBOutlet weak var replyButton: SpringButton!
	@IBOutlet weak var commentTextView: AutoTextView!
	
	@IBAction func upvoteButtonDidTouch(sender: AnyObject) {
	}
	
	@IBAction func replyButtonDidTouch(sender: AnyObject) {
	}
	
	func configureWithComment(comment: JSON) {
        let userDisplayname   = comment["user_display_name"].string!
        let	userJob           = comment["user_job"].string!
        let createdAt         = comment["created_at"].string!
        let voteCount         = comment["vote_count"].int!
        let body              = comment["body"].string!

        avatarImageView.image = UIImage(named: "content-avatar-default")
        authorLabel.text      = userDisplayname + ", " + userJob
        timeLabel.text        = timeAgoSinceDate((dateFromString(createdAt, format: "yyyy-MM-dd'THH:mm:ssZ")), numericDates: true)
		upvoteButton.setTitle(String(voteCount), forState: UIControlState.Normal)
        commentTextView.text  = body
	}

}
