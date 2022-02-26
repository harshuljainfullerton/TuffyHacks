//
//  TaskModel.swift
//  HarshulAndMike
//
//  Created by Harshul Jain on 1/25/22.
//

import Foundation

struct TaskModel: Identifiable, Codable{
    let id: String
    let task: String;
    let isCompleted: Bool;
    
    init(id: String = UUID().uuidString, task: String, isCompleted: Bool) {
        self.id = id
        self.task = task
        self.isCompleted = isCompleted
    }
    
    func updateCompletion() -> TaskModel{
        return TaskModel(id: id, task: task, isCompleted: !isCompleted)
    }
}
