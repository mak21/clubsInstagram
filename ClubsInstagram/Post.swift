//
//  Post.swift
//  ClubsInstagram
//
//  Created by mahmoud khudairi on 4/15/17.
//  Copyright © 2017 mahmoud khudairi. All rights reserved.
//

import UIKit

class Post: NSObject {
    var id: String?
    var userId : String?
    var userName:String?
    var caption: String?
    var postImageUrl: String?
    var userProfileImageUrl: String?
    var likeImageIsTapped: Bool?
    var numberOfLikes: Int?
    init(dictionary: [String: AnyObject]) {
        
        self.id = dictionary["id"] as? String
        self.userId = dictionary["userId"] as? String
        self.userName = dictionary["userName"] as? String
        self.caption = dictionary["caption"] as? String
        self.postImageUrl = dictionary["postImageUrl"] as? String
        self.userProfileImageUrl = dictionary["userProfileImageURL"] as? String
        self.likeImageIsTapped = dictionary["likeImageIsTapped"] as? Bool
        self.numberOfLikes = dictionary["numberOfLikes"] as? Int
    }
}
