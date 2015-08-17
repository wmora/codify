//
//  CreateIssueViewController.swift
//  Codify
//
//  Created by William Mora on 14/8/15.
//  Copyright (c) 2015 nispok. All rights reserved.
//

import UIKit

class CreateIssueViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
    
    @IBAction func attachImage(sender: AnyObject) {
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            return
        }
        let imagePickerController = UIImagePickerController()
        imagePickerController.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
        imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePickerController.delegate = self
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        let imageData = UIImageJPEGRepresentation(image, 0)
        let imageBase64String = imageData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.allZeros)
        
        issueBody.text = "\(issueBody.text)\n\n<img src=\"data:image/jpg;base64,\(imageBase64String)\" width=250 />\n\n"
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        NSNotificationCenter.defaultCenter().addObserverForName(IssuesServiceNotification.CreateSuccess.rawValue, object: nil, queue: NSOperationQueue.mainQueue(), usingBlock: {
            (notification: NSNotification!) -> Void in
                self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        })
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: IssuesServiceNotification.CreateSuccess.rawValue, object: nil)
    }
    
}