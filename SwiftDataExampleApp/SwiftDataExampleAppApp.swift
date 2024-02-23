//
//  SwiftDataExampleAppApp.swift
//  SwiftDataExampleApp
//
//  Created by Abhishek on 23/02/24.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataExampleAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Student.self)
    }
}
