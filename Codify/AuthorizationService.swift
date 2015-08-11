//
//  AuthorizationService.swift
//  Codify
//
//  Created by William Mora on 9/8/15.
//  Copyright (c) 2015 nispok. All rights reserved.
//

import Foundation

public class AuthorizationService {
    
    let clientIdPlistKey = "GitHub Client ID"
    let clientSecretPlistKey = "GitHub Client Secret"
    let clientIdKey = "client_id"
    let clientSecretKey = "client_secret"
    let redirectURIKey = "redirect_uri"
    let redirectURI = "nispok-codify://oauth-callback"
    let scopeKey = "scope"
    let state = "state"
    
    public init() {
    }
    
    func authorizationRequest() -> NSURLRequest {
        return NSURLRequest(URL: authorizationRequestURL())
    }
    
    public func authorizationRequestURL() -> NSURL {
        let credentialsPath = NSBundle.mainBundle().pathForResource("Credentials", ofType: "plist")
        let credentials = NSDictionary(contentsOfFile: credentialsPath!)!
        let clientId = credentials[clientIdPlistKey] as! NSString
        let clientSecret = credentials[clientSecretPlistKey] as! NSString
        let baseURL = "https://github.com/login/oauth/authorize"
        let url = NSURL(string: "\(baseURL)?\(clientIdKey)=\(clientId)&\(clientSecretKey)=\(clientSecret)&\(redirectURIKey)=\(redirectURI)")
        return url!
    }
    
}