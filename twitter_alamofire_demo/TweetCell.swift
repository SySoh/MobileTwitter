//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage
import ActiveLabel

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: ActiveLabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var retweetNumber: UILabel!
    @IBOutlet weak var likeNumber: UILabel!
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBAction func didPressFavorite(_ sender: Any) {
        if tweet.favorited {
            tweet.favorited = false
            tweet.favoriteCount! -= 1
            likeNumber.text = String(describing: tweet.favoriteCount!)
            favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
            print("unfavorited!")
            APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                }
            }
        } else {
            tweet.favorited = true
            tweet.favoriteCount! += 1
            likeNumber.text = String(describing: tweet.favoriteCount!)
            favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
            favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .selected)
            print("favorited!")
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
          
        }
    }
    
    
    @IBAction func didPressRetweet(_ sender: Any) {
        if tweet.retweeted {
            tweet.retweeted = false
            tweet.retweetCount -= 1
            retweetNumber.text = String(describing: tweet.retweetCount)
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
            print("unfavorited!")
            APIManager.shared.unretweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unretweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unretweeted the following Tweet: \n\(tweet.text)")
                }
            }
        } else {
            tweet.retweeted = true
            tweet.retweetCount += 1
            retweetNumber.text = String(describing: tweet.retweetCount)
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
            print("retweeted!")
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                }
            }
            
        }

    }
   
    
    //Sets tweet property whenever changed.
    var tweet: Tweet! {
        didSet {
           refreshCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func refreshCell(){
        tweetTextLabel.enabledTypes = [.mention, .hashtag, .url]
        tweetTextLabel.text = tweet.text
        tweetTextLabel.handleURLTap { (url) in
            UIApplication.shared.open(url)
        }
        nameLabel.text = tweet.user.name
        handleLabel.text = tweet.user.screenName
        dateLabel.text = tweet.createdAtString
        if tweet.retweeted {
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
        }
        else {
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
        }
        if tweet.favorited {
            favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
        }
        else {
            favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
        }
        retweetNumber.text = String(describing: tweet.retweetCount)
        likeNumber.text = String(describing: tweet.favoriteCount!)
        profilePhoto.af_setImage(withURL:tweet.profPhoto)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
