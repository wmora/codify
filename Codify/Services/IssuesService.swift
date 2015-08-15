//
//  IssuesService.swift
//  Codify
//
//  Created by William Mora on 14/8/15.
//  Copyright (c) 2015 nispok. All rights reserved.
//

import Foundation

public class IssuesService {
    
    var owner: String
    var repo: String
    
    public init(owner: String, repo: String) {
        self.owner = owner
        self.repo = repo
    }
    
    func createIssue(owner: String, repo: String, title: String, body: String) {
        
    }
    
    public func fullURL() -> NSURL {
        let baseURL = "https://api.github.com"
        return NSURL(string: "\(baseURL)/repos/\(owner)/\(repo)/issues")!
    }
}