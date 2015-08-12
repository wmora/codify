//
//  DismissSegue.swift
//  Codify
//
//  Created by William Mora on 12/8/15.
//  Copyright (c) 2015 nispok. All rights reserved.
//

import UIKit

class DismissSegue: UIStoryboardSegue {
    
    override func perform() {
        self.sourceViewController.presentingViewController!!.dismissViewControllerAnimated(true, completion: nil)
    }
    
}