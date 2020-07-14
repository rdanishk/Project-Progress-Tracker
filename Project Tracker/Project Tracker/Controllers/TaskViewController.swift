//
//  TaskViewController.swift
//  Project Tracker
//
//  Created by RecoveryTrek on 7/14/20.
//  Copyright © 2020 Danish Khalid. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {

    var task: Task?
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    override func viewWillAppear(_ animated: Bool) {
        self.title = task?.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.descriptionLabel.text = task?.desc
        self.dateLabel.text = task?.date
        self.commentLabel.text = task?.comments
    }
    @IBAction func saveBtnPressed(_ sender: UIButton) {
        if descriptionTextField.text != "" {
            task?.setValue(descriptionTextField.text, forKey: "desc")
            descriptionTextField.text = ""
        }
        if commentTextField.text != "" {
            task?.setValue(commentTextField.text, forKey: "comments")
            commentTextField.text = ""
        }
        self.descriptionLabel.text = task?.desc
        self.commentLabel.text = task?.comments
    }
    @IBAction func sendBtnPressed(_ sender: Any) {
        task?.setValue("InReview", forKey: "comments")
        self.commentLabel.text = task?.comments
        self.navigationController?.popViewController(animated: true)
    }
    
}
