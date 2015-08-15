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
    @IBOutlet weak var repo: UITextField!
    @IBOutlet weak var owner: UITextField!
    
    @IBAction func createIssue(sender: AnyObject) {
        if (repo.text.isEmpty || owner.text.isEmpty || issueTitle.text.isEmpty) {
            return
        }
        
        let service = IssuesService(owner: owner.text, repo:repo.text)
        service.createIssue(issueTitle.text, body: issueBody.text)
    }
    
}