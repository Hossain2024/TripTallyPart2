//
//  ViewController.swift
//  TripTally
//
//  Created by Maliha Hossain on 4/20/25.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var currencyLabel: UILabel!
    let budgetKey = "userBudget"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(handleBudgetUpdate(_:)), name: NSNotification.Name("budgetUpdated"), object: nil)
        if let savedBudget = UserDefaults.standard.string(forKey: "userBudget") {
            currencyLabel.text = savedBudget
        }
    }

    @objc func handleBudgetUpdate(_ notification: Notification) {
        if let newAmount = notification.object as? String {
            updateBudgetLabel(newAmount: newAmount)
        }
    }

    func updateBudgetLabel(newAmount: String) {
        currencyLabel.text = newAmount
    }
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "set Budget", message:"Enter your Budget for this trip", preferredStyle:.alert)
        
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter amount"
            textField.keyboardType = .decimalPad
        }
        
        
        let saveAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            if let text = alert.textFields?.first?.text,
                let amount = Double(text) {
                        
                let formatted = String(format: "$%.2f", amount)
                self?.currencyLabel.text = formatted
                        
                        
                UserDefaults.standard.set(formatted, forKey: self?.budgetKey ?? "")
                
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
            
    }
    
    
}

