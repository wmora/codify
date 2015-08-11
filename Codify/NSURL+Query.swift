//
//  NSURL+Query.swift
//  Codify
//
//  Created by William Mora on 10/8/15.
//  Copyright (c) 2015 nispok. All rights reserved.
//

import Foundation

public extension NSURL {
    
    public func queryParams() -> Dictionary<String, String> {
        var queryParams: Dictionary<String, String> = [:]

        for param in query!.componentsSeparatedByString("&") {
            let paramComponents = param.componentsSeparatedByString("=")
            let key = paramComponents[0]
            let value = paramComponents[1]
            
            if !key.isEmpty && !value.isEmpty {
                queryParams[key] = value
            }
        }
        
        return queryParams
    }
    
}
