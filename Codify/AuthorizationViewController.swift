//
//  AuthorizationViewController.swift
//  Codify
//
//  Created by William Mora on 9/8/15.
//  Copyright (c) 2015 nispok. All rights reserved.
//

import UIKit

class AuthorizationViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    var authorizationService: AuthorizationService?
    
    override func viewDidLoad() {
        authorizationService = AuthorizationService()
    }
    
    override func viewDidAppear(animated: Bool) {
        webView.loadRequest(authorizationService!.authorizationRequest())
    }
    
}