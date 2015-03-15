//
//  Log.swift
//  iDS
//
//  Created by Nikos Maounis on 23/2/15.
//  Copyright (c) 2015 Nikos Maounis. All rights reserved.
//

import Foundation

class Log {
    
    class func println(object: Any) {
        #if DEBUG
            Swift.println(object)
        #endif
    }
}
