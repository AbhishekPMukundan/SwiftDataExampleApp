//
//  ContentView.swift
//  SwiftDataExampleApp
//
//  Created by Abhishek on 23/02/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var context
    @State private var showAddSheet = false
    
    //an empty student list
    @Query(sort: \Student.name) var studentList: [Student]
    
    //variable to hold the selected object to update
    @State private var studentToUpdate: Student?
    
    var body: some View {
        //Navigation stage to get the Student list title in UI
        NavigationStack {
            
            // List to display all the students in the list
            List {
                ForEach(studentList) { student in
                    StudentCell(student: student)
                        // on tap to update the selected data
                        .onTapGesture {
                            studentToUpdate = student
                        }
                }
                // on swipe to delete
                .onDelete { indexSet in
                    for index in indexSet {
                        context.delete(studentList[index])
                    }
                }
            }
            .navigationTitle("Student List")
            .navigationBarTitleDisplayMode(.large)
            //a sheet is persenting an add student sheet.
            .sheet(isPresented: $showAddSheet) {AddStudent()}
            // sheet to update the student data
            .sheet(item: $studentToUpdate) { student in
                    UpdateStudent(student: student)
            }
            .toolbar {
                if !studentList.isEmpty {
                    Button("Add Student", systemImage: "plus") {
                        showAddSheet = true
                    }
                }
            }
            .overlay {
                //Default empty state
                if studentList.isEmpty {
                    ContentUnavailableView(label: {
                        Label("No Students", systemImage: "tray.fill")
                    }, description: {
                        Text("Start adding students to list")
                    }, actions: {
                        Button("Add Student") { showAddSheet = true }
                    })
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

struct StudentCell: View {
    
    let student: Student
    
    var body: some View {
        HStack {
            Text(student.name)
            Spacer()
            Text(student.age, format: .number)
        }
    }
}

struct AddStudent: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    
    //New student
    
    @State private var name: String = ""
    @State private var age: Double = 0
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Student Name", text: $name)
                TextField("Student Age", value: $age, format: .number)
                    .keyboardType(.numberPad)
            }
            .navigationTitle("New Student")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save") {
                        let student = Student(name: name, age: Double(age))
                        context.insert(student)
                        dismiss()
                    }
                }
            }
        }
    }
}

struct UpdateStudent: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var student: Student
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Student Name", text: $student.name)
                TextField("Student Age", value: $student.age, format: .number)
                    .keyboardType(.numberPad)
            }
            .navigationTitle("Update Student")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Update") {
                        dismiss()
                    }
                }
            }
        }
    }
}
