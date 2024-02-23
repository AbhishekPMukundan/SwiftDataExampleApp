//
//  Student.swift
//  SwiftDataExampleApp
//
//  Created by Abhishek on 23/02/24.
//

import Foundation
import SwiftData

@Model
class Student {
    var name: String
    var age: Double
    
    init(name: String, age: Double) {
        self.name = name
        self.age = age
    }
}
