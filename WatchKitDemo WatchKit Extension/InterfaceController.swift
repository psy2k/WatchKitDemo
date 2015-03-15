//
//  InterfaceController.swift
//  WatchKitDemo WatchKit Extension
//
//  Created by Nikos Maounis on 14/3/15.
//  Copyright (c) 2015 Nikos Maounis. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var newsTable: WKInterfaceTable!
    var articles = [Article]()

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String,
        inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
            if segueIdentifier == "articleDetails" {
                let article = articles[rowIndex]
                return article
            }
            
            return nil
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        WKInterfaceController.openParentApplication(["request": "refreshData"], reply: { (replyInfo, error) -> Void in
            if let articleData = replyInfo["articleData"] as? NSData {
                if let articles = NSKeyedUnarchiver.unarchiveObjectWithData(articleData) as? [Article] {
                    self.articles = articles
                    self.reloadTable()
                }
            }
        })
    }
    
    //MARK: Table loading
    func reloadTable() {
        newsTable.setNumberOfRows(articles.count, withRowType: "ArticleRow")
        
        for (index, article) in enumerate(articles) {
            if let row = newsTable.rowControllerAtIndex(index) as? ArticleRow {
                var currentTitle: String! = article.postTitle
                let finalTitleArray = currentTitle.componentsSeparatedByString("–")
                
                var finalTitle: String = finalTitleArray[1].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
                row.titleLabel.setText(finalTitle)
                row.detailLabel.setText(article.postDescription)
            }
        }
    }

}
