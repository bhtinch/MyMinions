//
//  EmployeeListTableViewController.swift
//  myLecture2.4App
//
//  Created by Benjamin Tincher on 1/14/21.
//

import UIKit

class EmployeeListTableViewController: UITableViewController {
    
    @IBOutlet weak var newEmployeeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EmployeeController.shared.loadFromPersistenceStore()
    }
    
    //  MARK: Actions
    @IBAction func addEmployeeButtonTapped(_ sender: Any) {
        guard let name = newEmployeeTextField.text, !name.isEmpty else { return }
        EmployeeController.shared.createEmployeeWith(name: name, isAvailable: true)
        newEmployeeTextField.text = ""
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EmployeeController.shared.employees.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "employeeCell", for: indexPath) as? EmployeeTableViewCell else { return UITableViewCell() }
        let employee = EmployeeController.shared.employees[indexPath.row]
        cell.employee = employee
        cell.delegate = self
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let employee = EmployeeController.shared.employees[indexPath.row]
            EmployeeController.shared.delete(employee: employee)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension EmployeeListTableViewController: TaskAssignedDelegate {
    func taskCompletedBy(_ sender: EmployeeTableViewCell) {
        guard let employee = sender.employee else { return }
        EmployeeController.shared.toggleAvailabilityFor(employee: employee)
        EmployeeController.shared.updateEmployee(employee: employee, isAvailable: employee.isAvailable, task: nil)
        sender.updateViews()
    }
    
    func taskAssignedTo(_ sender: EmployeeTableViewCell) {
        guard let employee = sender.employee,
              let task = employee.task
        else { return }
        EmployeeController.shared.toggleAvailabilityFor(employee: employee)
        EmployeeController.shared.updateEmployee(employee: employee, isAvailable: employee.isAvailable, task: task)
        sender.updateViews()
    }
    
}
