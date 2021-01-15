//
//  EmployeeTableViewCell.swift
//  myLecture2.4App
//
//  Created by Benjamin Tincher on 1/14/21.
//

import UIKit

protocol TaskAssignedDelegate: AnyObject {
    func taskAssignedTo(_ sender: EmployeeTableViewCell)
    func taskCompletedBy(_ sender: EmployeeTableViewCell)
}

class EmployeeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var employeeNameLabel: UILabel!
    @IBOutlet weak var employeeIsAvailableLabel: UILabel!
    @IBOutlet weak var coffeeButton: UIButton!
    @IBOutlet weak var sandwichButton: UIButton!
    @IBOutlet weak var reportsButton: UIButton!
    
    var employee: Employee? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: TaskAssignedDelegate?
    
    @IBAction func coffeeButtonTapped(_ sender: Any) {
        guard let employee = employee else { return }
        self.taskButtonTapped(employee: employee, targetTask: "coffee")
    }
    
    @IBAction func sandwichButtonTapped(_ sender: Any) {
        guard let employee = employee else { return }
        self.taskButtonTapped(employee: employee, targetTask: "sandwich")
    }
    
    @IBAction func reportsButtonTapped(_ sender: Any) {
        guard let employee = employee else { return }
        self.taskButtonTapped(employee: employee, targetTask: "reports")
    }
    
    func taskButtonTapped(employee: Employee, targetTask: String) {
        let task = employee.task
        switch task {
        case nil:
            employee.task = targetTask
            delegate?.taskAssignedTo(self)
            taskImageUpdate(employee: employee)
        case targetTask:
            delegate?.taskCompletedBy(self)
        default:
            return
        }
    }
    
    func updateViews() {
        guard let employee = employee else { return }
        employeeNameLabel.text = employee.name
        isAvailableStatusUpdate(employee: employee)
        taskImageUpdate(employee: employee)
    }
    
    func isAvailableStatusUpdate(employee: Employee) {
        
        if employee.isAvailable {
            employeeIsAvailableLabel.text = "Available"
            employeeIsAvailableLabel.textColor = .green
        } else {
            employeeIsAvailableLabel.text = "Busy"
            employeeIsAvailableLabel.textColor = .red
        }
    }
    
    func taskImageUpdate(employee: Employee) {
        
        if employee.task != nil {
            
            coffeeButton.isEnabled = false
            sandwichButton.isEnabled = false
            reportsButton.isEnabled = false
            
            if employee.task == "coffee" {
                coffeeButton.isEnabled = true } else
            if employee.task == "sandwich" {
                sandwichButton.isEnabled = true } else
            if employee.task == "reports" { reportsButton.isEnabled = true }
            
        } else {
            coffeeButton.isEnabled = true
            sandwichButton.isEnabled = true
            reportsButton.isEnabled = true
        }
    }
}
