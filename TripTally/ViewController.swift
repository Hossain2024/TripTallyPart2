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
        if let savedBudget = UserDefaults.standard.string(forKey: budgetKey) {
        currencyLabel.text = savedBudget
            
        }
        
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

