//
//  NSMutableURLRequest+GitHubTest.swift
//  Codify
//
//  Created by William Mora on 14/8/15.
//  Copyright (c) 2015 nispok. All rights reserved.
//

import XCTest
import Codify

class NSMutableURLRequest_GitHubTest: XCTestCase {

    func testGitHubHeadersShouldHaveAcceptHeader() {
        let urlRequest = NSMutableURLRequest(URL: NSURL(string: "https://example.com")!)
        urlRequest.gitHubHeaders()
        
        XCTAssertEqual(urlRequest.valueForHTTPHeaderField("Accept")!, "application/vnd.github.v3+json")
    }
    
    func testGitHubHeadersShouldHaveAuthorizationHeaderIfAuthenticated() {
        NSUserDefaults.standardUserDefaults().setValue("my_access_token", forKey: "access_token")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        let urlRequest = NSMutableURLRequest(URL: NSURL(string: "https://example.com")!)
        urlRequest.gitHubHeaders()
        
        XCTAssertEqual(urlRequest.valueForHTTPHeaderField("Authorization")!, "my_access_token")
        
        NSUserDefaults.standardUserDefaults().removeObjectForKey("access_token")
    }
    
    func testGitHubHeadersShouldNotHaveAuthorizationIfNotAuthenticated() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey("access_token")
        
        let urlRequest = NSMutableURLRequest(URL: NSURL(string: "https://example.com")!)
        urlRequest.gitHubHeaders()
        
        XCTAssertNil(urlRequest.valueForHTTPHeaderField("Authorization"))
    }

}
