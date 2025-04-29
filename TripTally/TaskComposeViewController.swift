//
//  TaskComposeViewController.swift
//  TripTally
//
//  Created by Maliha Hossain on 4/24/25.
//

import UIKit

class TaskComposeViewController: UIViewController {

    @IBOutlet weak var titleField: UITextField!
   
       var taskToEdit: Task?
       var onComposeTask: ((Task) -> Void)? = nil

       
    override func viewDidLoad() {
        super.viewDidLoad()

        // 1.
        if let task = taskToEdit {
            titleField.text = task.title
            // 2.
            self.title = "Edit Task"
        }
    }
    
    
    @IBAction func didTapDoneButton(_ sender: Any) {
        guard let title = titleField.text, !title.isEmpty else {
                presentAlert(title: "Oops...", message: "Make sure to add a title!")
                return
            }

            var task: Task
            if let editTask = taskToEdit {
                task = editTask
                task.title = title
            } else {
                task = Task(title: title)
            }
            
           
            onComposeTask?(task)
            dismiss(animated: true)
    }
    
    
    @IBAction func didTapCancelButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
        private func presentAlert(title: String, message: String) {
            // 1.
            let alertController = UIAlertController(
                title: title,
                message: message,
                preferredStyle: .alert)
            // 2.
            let okAction = UIAlertAction(title: "OK", style: .default)
            // 3.
            alertController.addAction(okAction)
            // 4.
            present(alertController, animated: true)
        }
    
    }

