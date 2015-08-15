//
//  CreateIssueViewController.swift
//  Codify
//
//  Created by William Mora on 14/8/15.
//  Copyright (c) 2015 nispok. All rights reserved.
//

import UIKit

class CreateIssueViewController: UIViewController {
    
    @IBOutlet weak var issueTitle: UITextField!
    @IBOutlet weak var issueBody: UITextView!
    
    @IBAction func createIssue(sender: AnyObject) {
        if (issueTitle.text.isEmpty && issueBody.text.isEmpty) {
            return
        }
        
        let service = IssuesService(owner:"wmora", repo:"test-repo")
        service.createIssue(issueTitle.text, body: issueBody.text)
    }
    
}