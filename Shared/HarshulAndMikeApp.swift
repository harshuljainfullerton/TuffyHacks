//
//  HarshulAndMikeApp.swift
//  Shared
//
//  Created by Harshul Jain on 1/23/22.
//

import SwiftUI

@main
struct HarshulAndMikeApp: App {
    
    @StateObject var taskViewModel: TaskViewModel = TaskViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                TaskView()
            }
            .environmentObject(taskViewModel)
        }
    }
}
