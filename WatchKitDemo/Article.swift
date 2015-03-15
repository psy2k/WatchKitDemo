//
//  Article.swift
//  iDS
//
//  Created by Nikos Maounis on 5/10/14.
//  Copyright (c) 2014 Nikos Maounis. All rights reserved.
//

import Foundation

@objc(Article)
class Article : NSObject, NSCoding, Printable {
    
    var postTitle: String = String()
    var postLink: String = String()
    var postDescription : String = String()
    var articleDetails : String = String()
    var pubDate : NSDate = NSDate()
    
    required convenience init(coder decoder: NSCoder) {
        self.init()
        self.postTitle = decoder.decodeObjectForKey("postTitle") as String!
        self.postLink = decoder.decodeObjectForKey("postLink") as String!
        self.postDescription = decoder.decodeObjectForKey("postDescription") as String!
        self.articleDetails = decoder.decodeObjectForKey("articleDetails") as String!
        self.pubDate = decoder.decodeObjectForKey("pubDate") as NSDate!
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.postTitle, forKey: "postTitle")
        coder.encodeObject(self.postLink, forKey: "postLink")
        coder.encodeObject(self.postDescription, forKey: "postDescription")
        coder.encodeObject(self.articleDetails, forKey: "articleDetails")
        coder.encodeObject(self.pubDate, forKey: "pubDate")
    }
}