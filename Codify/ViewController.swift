//
//  ViewController.swift
//  Codify
//
//  Created by William Mora on 9/8/15.
//  Copyright (c) 2015 nispok. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var authenticationService = AuthenticationService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginPressed(sender: AnyObject) {
        let authorizationUrl = authenticationService.authorizationRequestURL()
        UIApplication.sharedApplication().openURL(authorizationUrl)
    }

}

