//
//  XMLParser.swift
//  iDS
//
//  Created by Nikos Maounis on 4/10/14.
//  Copyright (c) 2014 Nikos Maounis. All rights reserved.
//

import UIKit

protocol XMLParserDelegate: class {
    func parsingWasFinished()
}

class XMLParser: NSObject, NSXMLParserDelegate {
    
    var arrParsedData = [Article]()
    var currentDataDictionary = Dictionary<String, String>()
    var currentElement = ""
    var foundCharacters = ""
    var postTitle: String = String()
    var postLink: String = String()
    var postDescription : String = String()
    var articleDetails : String = String()
    var eName: String = String()
    var pubDate : NSDate = NSDate()
    weak var delegate : XMLParserDelegate?
    
    func startParsingWithContentsOfURL(rssURL: NSURL) {
        let parser = NSXMLParser(contentsOfURL: rssURL)
        parser!.delegate = self
        parser!.parse()
    }
    
    func startParsing(url: NSURL, completionClosure: (articles :[Article]?, error: NSError?) ->()) {
        let parser = NSXMLParser(contentsOfURL: url)
        parser!.delegate = self
        parser!.parse()
        return completionClosure(articles: self.arrParsedData, error: nil)
    }
    
    // MARK: - NSXMLParserDelegate methods
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        eName = elementName
        if elementName == "item" {
            postTitle = String()
            postLink = String()
            postDescription = String()
            articleDetails = String()
            pubDate = NSDate()
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
        let data = string!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let dataWithLines = string!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        if (!data.isEmpty) {
            if eName == "title" {
                postTitle += data
            } else if eName == "link" {
                postLink += data
            } else if eName == "content:encoded" {
                let strClean = data.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil)
                var decodedString = String.stringByRemovingHTMLEntities(strClean)
                postDescription += decodedString
                articleDetails += dataWithLines
            } else if eName == "pubDate" {
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss ZZ"
                // Locale is needed in order to work on actual device
                dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
                let date = dateFormatter.dateFromString(data)
                if (date != nil) {
                    pubDate = date!
                }
            }
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let article : Article = Article()
            article.postTitle = postTitle
            article.postLink = postLink
            article.postDescription = postDescription
            article.articleDetails = articleDetails
            article.pubDate = pubDate
            arrParsedData.append(article)
            Log.println("Added article: \(postTitle)")
        }
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        delegate?.parsingWasFinished()
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        Log.println(parseError.description)
    }
    
    func parser(parser: NSXMLParser, validationErrorOccurred validationError: NSError) {
        Log.println(validationError.description)
    }
    
    func cacheArticleData(coins: [Article]) {
        NSUserDefaults.standardUserDefaults().setObject(NSKeyedArchiver.archivedDataWithRootObject(coins), forKey: "articleData")
        NSUserDefaults.standardUserDefaults().setObject(NSDate(), forKey: "date")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func cachedArticles() -> [Article] {
        if let articleData = NSUserDefaults.standardUserDefaults().objectForKey("articleData") as? NSData {
            if let articles = NSKeyedUnarchiver.unarchiveObjectWithData(articleData) as? [Article] {
                return articles
            }
        }
        return []
    }
}

