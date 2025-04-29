//
//  Task.swift
//  TripTally
//
//  Created by Maliha Hossain on 4/24/25.
//

//
//  Task.swift
//

import UIKit

// The Task model
struct Task: Codable{
    
    // The task's title
    var title: String
    
    init(title: String) {
        self.title = title
        
    }
    
   
    var isComplete: Bool = false {
        didSet {
            if isComplete {
                
            } else {
                
            }
        }
    }
    
   
    private(set) var id: String = UUID().uuidString
    func save() {

            // TODO: Save the current task
            var tasks = Task.getTasks()
            if let index = tasks.firstIndex(where: { $0.id == self.id }) {
                    // Update the existing task
                    tasks[index] = self
                } else {
                    // Add the new task
                    tasks.append(self)
                }
            Task.save(tasks)
    }
}
    
// MARK: - Task + UserDefaults
extension Task {


    
    static var taskKey: String {
            return "tasks"
        }

    // Retrieve an array of saved tasks from UserDefaults.
    static func getTasks() -> [Task] {
            let key = Task.taskKey
            let defaults = UserDefaults.standard
               // 2.
               if let data = defaults.data(forKey: key) {
                   // 3.
                   let decodedTasks = try! JSONDecoder().decode([Task].self, from: data)
                   // 4.
                   return decodedTasks
               } else {
                   // 5.
                   return []
               }
    }

    // Add a new task or update an existing task with the current task.
    static func save(_ tasks: [Task]) {
           let key = Task.taskKey
           let defaults = UserDefaults.standard
           
           let encodedData = try! JSONEncoder().encode(tasks)
           defaults.set(encodedData, forKey: key)
           
       }
}
