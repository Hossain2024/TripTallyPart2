//
//  TaskCell.swift
//  TripTally
//
//  Created by Maliha Hossain on 4/24/25.
//

//
//  TaskCell.swift
//

import UIKit

class TaskCell: UITableViewCell {
    
    
    
    @IBOutlet weak var CompleteButton: UIButton!
    @IBOutlet weak var TitleLabel: UILabel!
    var onRequestAmountAndComplete: ((Task, @escaping (Double?) -> Void) -> Void)?
   
    var onCompleteButtonTapped: ((Task,Double) -> Void)?
    var task: Task!


    @IBAction func DidTapCompleteButton(_ sender: UIButton) {
        guard let task = task else { return }

                // Ask the VC to prompt for an amount
                onRequestAmountAndComplete?(task) { [weak self] amount in
                    guard let self = self, let amount = amount else { return }

                    // Mark complete and update UI
                    self.task.isComplete = true
                    self.update(with: self.task)

                    // Call final completion with task and amount
                    self.onCompleteButtonTapped?(self.task, amount)
        }
    }
    
    func configure(with task: Task,
                       onRequestAmountAndComplete: ((Task, @escaping (Double?) -> Void) -> Void)?,
                       onCompleteButtonTapped: ((Task, Double) -> Void)?) {
            self.task = task
            self.onRequestAmountAndComplete = onRequestAmountAndComplete
            self.onCompleteButtonTapped = onCompleteButtonTapped
            update(with: task)
    }


    private func update(with task: Task) {
        TitleLabel.text = task.title
        CompleteButton.isSelected = task.isComplete
        CompleteButton.tintColor = task.isComplete ? .systemBlue : .tertiaryLabel
        TitleLabel.textColor = task.isComplete ? .secondaryLabel : .label
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) { }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) { }
}
