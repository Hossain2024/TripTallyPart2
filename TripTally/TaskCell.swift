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
    
   
    var onCompleteButtonTapped: ((Task) -> Void)?
    var task: Task!


    @IBAction func DidTapCompleteButton(_ sender: UIButton) {
        task.isComplete = !task.isComplete
        update(with:task)
        onCompleteButtonTapped?(task)
        
    }
    
    func configure(with task: Task, onCompleteButtonTapped: ((Task) -> Void)?) {
        // 1.
        self.task = task
        // 2.
        self.onCompleteButtonTapped = onCompleteButtonTapped
        // 3.
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
