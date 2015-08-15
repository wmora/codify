//
//  AuthorizationService.swift
//  Codify
//
//  Created by William Mora on 9/8/15.
//  Copyright (c) 2015 nispok. All rights reserved.
//

import Foundation

public class AuthenticationService {
    
    let clientIdPlistKey = "GitHub Client ID"
    let clientSecretPlistKey = "GitHub Client Secret"
    let clientIdKey = "client_id"
    let clientSecretKey = "client_secret"
    let redirectURIKey = "redirect_uri"
    let redirectURI = "nispok-codify://oauth-callback"
    let scopesKey = "scope"
    let scopes = "repo,notifications,user"
    let state = "state"
    let accessTokenKey = "access_token"
    let codeKey = "code"
    
    public init() {
    }
    
    public func authorizationRequestURL() -> NSURL {
        let baseURL = "https://github.com/login/oauth/authorize"
        let url = NSURL(string: "\(baseURL)?\(clientIdKey)=\(clientId())&\(clientSecretKey)=\(clientSecret())&\(redirectURIKey)=\(redirectURI)&\(scopesKey)=\(scopes)")
        return url!
    }
    
    func authenticate(code: String) {
        let baseURL = "https://github.com/login/oauth/access_token"
        let url = NSURL(string: "\(baseURL)?\(clientIdKey)=\(clientId())&\(clientSecretKey)=\(clientSecret())&\(redirectURIKey)=\(redirectURI)&\(codeKey)=\(code)")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            if (error != nil) {
                return
            }
            let responseData = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
            self.saveAccessToken(responseData[self.accessTokenKey] as! String)
        }
        task.resume()
    }
    
    public func isAuthenticated() ->  Bool {
        let token = accessToken()
        
        return token != nil && !token!.isEmpty
    }
    
    private func saveAccessToken(accessToken: String) {
        NSUserDefaults.standardUserDefaults().setValue(accessToken, forKey: accessTokenKey)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func accessToken() -> String? {
        return NSUserDefaults.standardUserDefaults().stringForKey(accessTokenKey)
    }
    
    func credentials() -> NSDictionary {
        let credentialsPath = NSBundle.mainBundle().pathForResource("Credentials", ofType: "plist")
        return NSDictionary(contentsOfFile: credentialsPath!)!
    }
    
    func clientId() -> NSString {
        return credentials()[clientIdPlistKey] as! NSString
    }
    
    func clientSecret() -> NSString {
        return credentials()[clientSecretPlistKey] as! NSString
    }
    
}