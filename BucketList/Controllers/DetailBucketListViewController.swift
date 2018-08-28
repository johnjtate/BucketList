//
//  DetailBucketListViewController.swift
//  BucketList
//
//  Created by John Tate on 8/23/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

class DetailBucketListViewController: UIViewController {

    // Landing pad/mailbox
    var bucketListItem: BucketListItem?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    func updateViews() {
        guard let bucketListItem = bucketListItem else { return }
    
        titleTextField.text = bucketListItem.title
        ageTextField.text = "\(bucketListItem.age)"
        bodyTextView.text = bucketListItem.description
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        // Forced at least the text field to be completed before saving
        guard titleTextField != nil else { return }
        
        guard let title = titleTextField.text,
            let ageString = ageTextField.text,
            let age = Int(ageString),
            let description = bodyTextView.text else { return }
        
        if let bucketListItem = bucketListItem {
            BucketListItemController.shared.update(bucketListItem: bucketListItem, newTitle: title, newAge: age, newDescription: description)
        } else {
            BucketListItemController.shared.create(title: title, age: age, description: description)
        }

        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        titleTextField.text = ""
        ageTextField.text = ""
        bodyTextView.text = ""
        
    }
    
    
}
