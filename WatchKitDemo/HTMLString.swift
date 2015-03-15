//
//  HTMLString.swift
//  iDS
//
//  Created by Nikos Maounis on 5/10/14.
//  Copyright (c) 2014 Nikos Maounis. All rights reserved.
//

import Foundation

extension String {
    static func stringByRemovingHTMLEntities(string: String) -> String {
        var result = string
        
        result = result.stringByReplacingOccurrencesOfString("<p>", withString: "\n\n", options: .CaseInsensitiveSearch, range: nil)
        result = result.stringByReplacingOccurrencesOfString("</p>", withString: "", options: .CaseInsensitiveSearch, range: nil)
        result = result.stringByReplacingOccurrencesOfString("&#8211;", withString: "-", options: .CaseInsensitiveSearch, range: nil)
        result = result.stringByReplacingOccurrencesOfString("&#8220;", withString: "\"", options: .CaseInsensitiveSearch, range: nil)
        result = result.stringByReplacingOccurrencesOfString("&#8221;", withString: "\"", options: .CaseInsensitiveSearch, range: nil)
        result = result.stringByReplacingOccurrencesOfString("<i>", withString: "", options: .CaseInsensitiveSearch, range: nil)
        result = result.stringByReplacingOccurrencesOfString("</i>", withString: "", options: .CaseInsensitiveSearch, range: nil)
        result = result.stringByReplacingOccurrencesOfString("&#38;", withString: "&", options: .CaseInsensitiveSearch, range: nil)
        result = result.stringByReplacingOccurrencesOfString("&#62;", withString: ">", options: .CaseInsensitiveSearch, range: nil)
        result = result.stringByReplacingOccurrencesOfString("&#x27;", withString: "'", options: .CaseInsensitiveSearch, range: nil)
        result = result.stringByReplacingOccurrencesOfString("&#x2F;", withString: "/", options: .CaseInsensitiveSearch, range: nil)
        result = result.stringByReplacingOccurrencesOfString("&quot;", withString: "\"", options: .CaseInsensitiveSearch, range: nil)
        result = result.stringByReplacingOccurrencesOfString("&#60;", withString: "<", options: .CaseInsensitiveSearch, range: nil)
        result = result.stringByReplacingOccurrencesOfString("&lt;", withString: "<", options: .CaseInsensitiveSearch, range: nil)
        result = result.stringByReplacingOccurrencesOfString("&gt;", withString: ">", options: .CaseInsensitiveSearch, range: nil)
        result = result.stringByReplacingOccurrencesOfString("&amp;", withString: "&", options: .CaseInsensitiveSearch, range: nil)
        result = result.stringByReplacingOccurrencesOfString("<pre><code>", withString: "", options: .CaseInsensitiveSearch, range: nil)
        result = result.stringByReplacingOccurrencesOfString("</code></pre>", withString: "", options: .CaseInsensitiveSearch, range: nil)
        
        var regex = NSRegularExpression(pattern: "<a[^>]+href=\"(.*?)\"[^>]*>.*?</a>",
            options: NSRegularExpressionOptions.CaseInsensitive, error: nil)
        result = regex!.stringByReplacingMatchesInString(result, options: nil, range: NSMakeRange(0, result.utf16Count), withTemplate: "$1")
        
        return result
    }
    
    func stringByDecodingHTMLEntities() -> String? {
        var r: NSRange
        let pattern = "<[^>]+>"
        var s = self.stringByDecodingHTMLEscapeCharacters()
        r = (s as NSString).rangeOfString(pattern, options: NSStringCompareOptions.RegularExpressionSearch)
        while (r.location != NSNotFound) {
            s = (s as NSString).stringByReplacingCharactersInRange(r, withString: " ")
            r = (s as NSString).rangeOfString(pattern, options: NSStringCompareOptions.RegularExpressionSearch)
        }
        return s.stringByReplacingOccurrencesOfString("  ", withString: " ")
    }
    
    func stringByDecodingHTMLEscapeCharacters() -> String {
        var s = self.stringByReplacingOccurrencesOfString("&quot;", withString: "\"")
        s = s.stringByReplacingOccurrencesOfString("&apos;", withString: "'")
        s = s.stringByReplacingOccurrencesOfString("&amp;", withString: "&")
        s = s.stringByReplacingOccurrencesOfString("&lt;", withString: "<")
        s = s.stringByReplacingOccurrencesOfString("&gt;", withString: ">")
        s = s.stringByReplacingOccurrencesOfString("&#39;", withString: "'")
        s = s.stringByReplacingOccurrencesOfString("&ldquot;", withString: "\"")
        s = s.stringByReplacingOccurrencesOfString("&rdquot;", withString: "\"")
        s = s.stringByReplacingOccurrencesOfString("&nbsp;", withString: " ")
        s = s.stringByReplacingOccurrencesOfString("&aacute;", withString: "á")
        s = s.stringByReplacingOccurrencesOfString("&eacute;", withString: "é")
        s = s.stringByReplacingOccurrencesOfString("&iacute;", withString: "í")
        s = s.stringByReplacingOccurrencesOfString("&oacute;", withString: "ó")
        s = s.stringByReplacingOccurrencesOfString("&uacute;", withString: "ú")
        s = s.stringByReplacingOccurrencesOfString("&ntilde;", withString: "ñ")
        s = s.stringByReplacingOccurrencesOfString("&#8217;", withString: "'")
        
        return s
    }
}
