//
//  EmployeeController.swift
//  myLecture2.4App
//
//  Created by Benjamin Tincher on 1/14/21.
//

import Foundation

class EmployeeController {
    
    static let shared = EmployeeController()
    
    var employees:[Employee] = []
    
    //  CRUD
    
    //  CREATE
    func createEmployeeWith(name: String, isAvailable: Bool) {
        let employee = Employee(name: name, isAvailable: isAvailable, task: nil)
        employees.append(employee)
        saveToPersistenceStore()
    }
    
    func updateEmployee(employee: Employee, isAvailable: Bool, task: String?) {
        employee.task = task
        employee.isAvailable = isAvailable
        saveToPersistenceStore()
    }
    
    func delete(employee: Employee) {
        guard let index = employees.firstIndex(of: employee) else { return }
        employees.remove(at: index)
        saveToPersistenceStore()
    }
    
    func toggleAvailabilityFor(employee: Employee) {
        employee.isAvailable.toggle()
        saveToPersistenceStore()
    }
    
    //  MARK: - Persistence

    //  fileURL
    func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("Employee.json")
        return fileURL
    }

    //  save
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(employees)
            try data.write(to: fileURL())
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }

    //  load
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: fileURL())
            employees = try JSONDecoder().decode([Employee].self, from: data)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}

