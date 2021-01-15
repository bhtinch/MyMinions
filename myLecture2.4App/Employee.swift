//
//  Employee.swift
//  myLecture2.4App
//
//  Created by Benjamin Tincher on 1/14/21.
//

import Foundation

class Employee: Codable {
    let name: String
    var isAvailable: Bool
    var task: String?
    
    init(name: String, isAvailable: Bool, task: String?) {
        self.name = name
        self.isAvailable = isAvailable
        self.task = task
    }
}

extension Employee: Equatable {
    static func == (lhs: Employee, rhs: Employee) -> Bool {
        lhs.name == rhs.name && lhs.isAvailable == rhs.isAvailable && lhs.task == rhs.task
    }
}
