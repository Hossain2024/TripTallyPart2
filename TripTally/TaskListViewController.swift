//
//  TaskListViewController.swift
//  TripTally
//
//  Created by Maliha Hossain on 4/24/25.
//

import UIKit

class TaskListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var tasks = [Task]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableHeaderView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        
        
    }
    
    override func viewDidAppear(_ animated: Bool){
        
        super.viewDidAppear(animated)
        refreshTasks()
    }
    
    
    @IBAction func didTapNewTaskButton(_ sender: Any) {
        performSegue(withIdentifier: "ComposeSegue", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ComposeSegue" {
            if let composeNavController = segue.destination as? UINavigationController,
                let composeViewController = composeNavController.topViewController as? TaskComposeViewController {

                // Pass the task to edit if available
                composeViewController.taskToEdit = sender as? Task

                // Set the closure that will handle the task after it is saved
                composeViewController.onComposeTask = { [weak self] task in
                    task.save()  // Save the task
                    self?.refreshTasks()  // Refresh the task list to show the newly added or edited task
                }
            }
        }
    }

    
    private func refreshTasks() {
            // 1.
            var tasks = Task.getTasks()

            // 2
            self.tasks = tasks
            // 4.
          
            // 5.
            tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
    }
extension TaskListViewController: UITableViewDataSource {
    
    // The number of rows to show
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    // Create and configure a cell for each row of the table view (i.e. each task in the tasks array)
    // 1. Dequeue a Task cell.
    // 2. Get the task for the associated row.
    // 3. Configure the cell with the task and add the code to be run when the complete button is tapped...
    //    i. Save the task passed back in the closure.
    //    ii. Refresh the tasks list to reflect the updates with the saved task.
    // 4. Return the configured cell.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1.
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        // 2.
        let task = tasks[indexPath.row]
        // 3.
        cell.configure(with: task, onCompleteButtonTapped: { [weak self] task in
            // i.
            task.save()
            // ii.
            self?.refreshTasks()
        })
        // 4.
        return cell
    }
    


func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    // 1.
    if editingStyle == .delete {
        // 2.
        tasks.remove(at: indexPath.row)
        // 3.
        Task.save(tasks)
        // 4.
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
}

extension TaskListViewController: UITableViewDelegate {

    // The table view delegate method called when a row is selected.
    // In this case, the user has tapped an existing task row and we want to segue them to the Compose View Controller to edit the associated task.
    // 1. Deselect the row so the row doesn't stay in the slected state. (This is just a design preference in this case).
    // 2. Get the task associated with the selected row.
    // 3. Perform the segue to the Compose View Controller (i.e. "ComposeSegue") passing in the selected task for the sender.
    //    - The sender can be any type and you can use it however you want. In this case we pass in the selected task so we can have easy access to it when preparing for navigation to the Compose View Controller when preparing for the segue in prepare(for:sender)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1.
        tableView.deselectRow(at: indexPath, animated: false)
        // 2.
        let selectedTask = tasks[indexPath.row]
        // 3.
        performSegue(withIdentifier: "ComposeSegue", sender: selectedTask)
    }
}


