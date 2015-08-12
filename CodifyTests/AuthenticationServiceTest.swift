//
//  AuthorizationServiceTest.swift
//  Codify
//
//  Created by William Mora on 9/8/15.
//  Copyright (c) 2015 nispok. All rights reserved.
//

import XCTest
import Codify

class AuthenticationServiceTest: XCTestCase {
    
    override func tearDown() {
        NSUserDefaults.resetStandardUserDefaults()
    }
    
    func testAuthorizationRequestURL() {
        let authorizationService = AuthenticationService()
        let actualURL = authorizationService.authorizationRequestURL()
        let credentialsPath = NSBundle.mainBundle().pathForResource("Credentials", ofType: "plist")
        let credentials = NSDictionary(contentsOfFile: credentialsPath!)!
        let clientId = credentials["GitHub Client ID"] as! NSString
        let clientSecret = credentials["GitHub Client Secret"] as! NSString

        let expectedURL = NSURL(string: "https://github.com/login/oauth/authorize?client_id=\(clientId)&client_secret=\(clientSecret)&redirect_uri=nispok-codify://oauth-callback")
        
        XCTAssertEqual(expectedURL!, actualURL)
    }
    
    func testIsAuthenticatedWithNilAccessTokenShouldReturnFalse() {
        NSUserDefaults.resetStandardUserDefaults()
        
        XCTAssertFalse(AuthenticationService().isAuthenticated())
    }

    func testIsAuthenticatedWithEmptyAccessTokenShouldReturnFalse() {
        NSUserDefaults.standardUserDefaults().setObject("", forKey: "access_token")
        
        XCTAssertFalse(AuthenticationService().isAuthenticated())
    }

    
    func testIsAuthenticatedWithAccessTokenShouldReturnTrue() {
        NSUserDefaults.standardUserDefaults().setObject("1234", forKey: "access_token")
        
        XCTAssertTrue(AuthenticationService().isAuthenticated())
    }
    
}