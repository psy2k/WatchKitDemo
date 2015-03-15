//
//  ArticleDetailInterfaceController.swift
//  iDS
//
//  Created by Nikos Maounis on 14/3/15.
//  Copyright (c) 2015 Nikos Maounis. All rights reserved.
//

import WatchKit
import Foundation

class ArticleDetailInterfaceController: WKInterfaceController {
    var article: Article!
    
    @IBOutlet weak var articleDetailTable: WKInterfaceTable!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        if let article = context as? Article {
            self.article = article
            self.reloadTable()
        }
    }
    
    //MARK: Table loading
    func reloadTable() {
        articleDetailTable.setNumberOfRows(1, withRowType: "ArticleDetailsRow")
        
        if let row = articleDetailTable.rowControllerAtIndex(0) as? ArticleDetailRow {
            var articleDescription: String! = article.postDescription
            row.textLabel.setText(articleDescription)
        }
    }
}
