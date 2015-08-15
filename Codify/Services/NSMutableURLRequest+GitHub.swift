//
//  NSMutableURLRequest+GitHub.swift
//  Codify
//
//  Created by William Mora on 14/8/15.
//  Copyright (c) 2015 nispok. All rights reserved.
//

import Foundation

public extension NSMutableURLRequest {
    
    public func gitHubHeaders() {
        setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        let authenticationService = AuthenticationService()
        if authenticationService.isAuthenticated() {
            setValue(authenticationService.accessToken(), forHTTPHeaderField: "Authorization")
        }
    }
}