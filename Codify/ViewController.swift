//
//  ViewController.swift
//  Codify
//
//  Created by William Mora on 9/8/15.
//  Copyright (c) 2015 nispok. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var authorizationService = AuthorizationService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginPressed(sender: AnyObject) {
        let authorizationUrl = authorizationService.authorizationRequestURL()
        UIApplication.sharedApplication().openURL(authorizationUrl)
    }

}

