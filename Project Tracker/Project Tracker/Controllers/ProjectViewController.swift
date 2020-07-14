//
//  ProjectViewController.swift
//  Project Tracker
//
//  Created by RecoveryTrek on 7/14/20.
//  Copyright © 2020 Danish Khalid. All rights reserved.
//

import UIKit

class ProjectViewController: UIViewController {

    @IBOutlet weak var taskTableView: UITableView!
    var project: Project?
    var tasks: [Task] = []
    
    let dateFormatter = DateFormatter()
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = project?.name
        self.tasks = (project?.tasks ?? []) as [Task]
        self.taskTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        taskTableView.delegate = self
        taskTableView.dataSource = self
        taskTableView.tableFooterView = UIView(frame: .zero)
    }
    
    @IBAction func addTaskPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "New Task", message: "Set Task", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            guard let nameTextField = alert.textFields?.first,
                let taskName = nameTextField.text else {
                    return
            }
            let date = Date()
            self.dateFormatter.dateFormat = "MM/dd/yyyy"
            let currentDate = self.dateFormatter.string(from: date)
            
            if let task = Task(name: taskName, desc: "", comments: "", date: currentDate) {
                self.project?.addToTask(task)
                do {
                    try task.managedObjectContext?.save()
                } catch {
                    print(error)
                }
            }
            self.tasks = (self.project?.tasks ?? []) as [Task]
            self.taskTableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? TaskViewController,
            let selectedRow = self.taskTableView.indexPathForSelectedRow?.row else {
                return
        }
        
        destination.task = tasks[selectedRow]
    }
}

extension ProjectViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        if let task = project?.tasks?[indexPath.row] {
            cell.textLabel?.text = task.name
            if let comment = task.comments {
                cell.detailTextLabel?.text = comment
            }
        }
        return cell
    }
}

extension ProjectViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "TaskDetailSegue", sender: self)
    }
}
