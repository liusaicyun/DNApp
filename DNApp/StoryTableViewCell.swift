//
//  StoryTableViewCell.swift
//  DNApp
//
//  Created by SaiCyun Liu on 2016-01-31.
//  Copyright © 2016年 SaiCyun Liu. All rights reserved.
//

import UIKit

protocol StoryTableViewCellDelegate: class {
	func storyTableViewCellDidTouchUpvote(cell: StoryTableViewCell, sender: AnyObject)
	func storyTableViewCellDidTouchComment(cell: StoryTableViewCell, sender: AnyObject)
}

class StoryTableViewCell: UITableViewCell {

    @IBOutlet weak var badgeImageView:  UIImageView!
    @IBOutlet weak var titleLabel:      UILabel!
    @IBOutlet weak var timeLabel:       UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var authorLabel:     UILabel!
    @IBOutlet weak var upvoteButton:    SpringButton!
    @IBOutlet weak var commentButton:   SpringButton!
	@IBOutlet weak var commentTextView: AutoTextView!
    weak var delegate:                  StoryTableViewCellDelegate?
	
	@IBAction func upvoteButtonDidTouch(sender: AnyObject) {
        upvoteButton.animation  = "pop"
        upvoteButton.force      = 3
		upvoteButton.animate()

		delegate?.storyTableViewCellDidTouchUpvote(self, sender: sender)
	}

	@IBAction func commentButtonDidTouch(sender: AnyObject) {
        commentButton.animation = "pop"
        commentButton.force     = 3
		commentButton.animate()

		delegate?.storyTableViewCellDidTouchComment(self, sender: sender)	// sender 是 commentButtonDidTouch 中的 sender，意思是完全转发出去
	}

	func configureWithStory(story: JSON) { //让 TableViewCell 的实例跟传入的 story 数据做映射。只要 story 符合 DataSource
        let title               = story["title"].string!
        let badge               = story["badge"].string ?? ""
        let userDisplayname     = story["user_display_name"].string!
        let	userJob             = story["user_job"].string ?? ""
        let createdAt           = story["created_at"].string!
        let voteCount           = story["vote_count"].int!
        let commentCount        = story["comment_count"].int!
        let comment             = story["comment"].string!

        titleLabel.text         = title
        badgeImageView.image    = UIImage(named: "badge-" + badge)
        avatarImageView.image   = UIImage(named: "content-avatar-default")
        authorLabel.text        = userDisplayname + ", " + userJob
        timeLabel.text          = timeAgoSinceDate((dateFromString(createdAt, format: "yyyy-MM-dd'THH:mm:ssZ")), numericDates: true)
		upvoteButton.setTitle(String(voteCount), forState: UIControlState.Normal)
		commentButton.setTitle(String(commentCount), forState: UIControlState.Normal)

        if let commentTextView  = commentTextView {
        commentTextView.text    = comment
		}
	}


}
