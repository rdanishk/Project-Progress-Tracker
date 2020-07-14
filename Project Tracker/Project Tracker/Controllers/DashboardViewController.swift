//
//  ViewController.swift
//  Project Tracker
//
//  Created by RecoveryTrek on 7/14/20.
//  Copyright © 2020 Danish Khalid. All rights reserved.
//

import UIKit
import CoreData

class DashboardViewController: UIViewController {

    @IBOutlet weak var projectTableView: UITableView!
    
    var projects: [Project] = []
    
    //Hiding navigation bar from the initial view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        self.updateViewFromModel()
        projectTableView.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        projectTableView.delegate = self
        projectTableView.dataSource = self
        projectTableView.tableFooterView = UIView(frame: .zero) //hiding empty lines
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? ProjectViewController,
            let selectedRow = self.projectTableView.indexPathForSelectedRow?.row else {
                return
        }
        
        destination.project = projects[selectedRow]
    }

    func updateViewFromModel() {
        //loading from model
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Project> = Project.fetchRequest()
        do {
            projects = try managedContext.fetch(fetchRequest)
        } catch {
            print(error)
        }
    }
    
    @IBAction func addProjectBtn(_ sender: UIButton) {
        let alert = UIAlertController(title: "New Project", message: "Set Project Name", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            guard let textField = alert.textFields?.first,
                let projectName = textField.text else {
                    return
            }
            let project = Project(name: projectName)
            do {
                try project?.managedObjectContext?.save()
            } catch {
                print(error)
            }
            self.updateViewFromModel()
            self.projectTableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}

extension DashboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let project = projects[indexPath.row]
        cell.textLabel?.text = project.value(forKeyPath: "name") as? String
        return cell
    }
}

extension DashboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ProjectDetailSegue", sender: self)
    }
}
