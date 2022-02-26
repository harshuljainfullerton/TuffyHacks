//
//  TaskRowView.swift
//  HarshulAndMike
//
//  Created by Harshul Jain on 1/25/22.
//
import UserNotifications
import SwiftUI

struct TaskRowView: View {
    
    let item:TaskModel
    
    var body: some View {
        HStack{
            Image(systemName: item.isCompleted ? "checkmark.circle": "circle")
                .foregroundColor(item.isCompleted ? .green : .red)
            Text(item.task)
            Spacer()
        }
        .font(.title2)
        .padding(.vertical, 8)
    }
}

struct TaskRowView_Previews: PreviewProvider {
    
    static var item1 = TaskModel(task: "hello boys", isCompleted: true)
    static var item2 = TaskModel(task: "hello there", isCompleted: false)

    
    static var previews: some View {
        Group{
            TaskRowView(item: item1)
            TaskRowView(item: item2)

        }
    }
}
