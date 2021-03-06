//
//  CreateIssueViewController.swift
//  Codify
//
//  Created by William Mora on 14/8/15.
//  Copyright (c) 2015 nispok. All rights reserved.
//

import UIKit

class CreateIssueViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var issueTitle: UITextField!
    @IBOutlet weak var issueBody: UITextView!
    @IBOutlet weak var repo: UITextField!
    @IBOutlet weak var owner: UITextField!
    
    @IBAction func createIssue(sender: AnyObject) {
        if (repo.text!.isEmpty || owner.text!.isEmpty || issueTitle.text!.isEmpty) {
            return
        }
        
        let service = IssuesService(owner: owner.text!, repo:repo.text!)
        service.createIssue(issueTitle.text!, body: issueBody.text!)
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
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        let imageData = UIImageJPEGRepresentation(image, 0)
        let imageBase64String = imageData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions())
        
        issueBody.text = "\(issueBody.text)\n\n<img src=\"data:image/jpg;base64,\(imageBase64String)\" width=250 />\n\n"
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        NSNotificationCenter.defaultCenter().addObserverForName(IssuesServiceNotification.CreateSuccess.rawValue, object: nil, queue: NSOperationQueue.mainQueue(), usingBlock: {
            (notification: NSNotification!) -> Void in
                self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        issueTitle.delegate = self
        repo.delegate = self
        owner.delegate = self
        issueBody.delegate = self
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: IssuesServiceNotification.CreateSuccess.rawValue, object: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
}