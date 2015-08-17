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
    
    func createIssue(title: String, body: String) {
        let request = NSMutableURLRequest(URL: fullURL())
        request.gitHubHeaders()
        request.HTTPMethod = "POST"
        let params = ["title": title, "body": body]
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: nil)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
                let statusCode = (response as? NSHTTPURLResponse)?.statusCode
            if (statusCode < 200 || statusCode >= 400 || error != nil) {
                NSNotificationCenter.defaultCenter().postNotificationName(IssuesServiceNotification.CreateFail.rawValue, object: self, userInfo: nil)
                return
            }
            
            let responseData = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
            NSNotificationCenter.defaultCenter().postNotificationName(IssuesServiceNotification.CreateSuccess.rawValue, object: self, userInfo: ["response": responseData])
        }
        task.resume()
    }
    
    public func fullURL() -> NSURL {
        let baseURL = "https://api.github.com"
        return NSURL(string: "\(baseURL)/repos/\(owner)/\(repo)/issues")!
    }
}