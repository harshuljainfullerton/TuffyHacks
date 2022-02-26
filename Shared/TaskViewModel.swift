//
//  TaskViewModel.swift
//  HarshulAndMike
//
//  Created by Harshul Jain on 1/25/22.
//

import Foundation
import UserNotifications

class RestingTime: ObservableObject {
    @Published var rest: Bool = false
    
    init() {
    }
    
    func changerest(rest: Bool){
        if (self.rest == true){
            self.rest = false;
        } else if (self.rest == false){
            self.rest = true
        }
    }
    
}

class TaskViewModel: ObservableObject {
    @Published var items: [TaskModel] = []{
        didSet{
            saveItems()
        }
    }
    
    let itemsKey: String = "item_list"
    
    init() {
        getItems()
    }
    
    func getItems(){
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([TaskModel].self, from: data)
        else {return}
        self.items = savedItems
    }
    
    func deleteTask(indexSet: IndexSet){
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int){
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String){
        let newItem = TaskModel(task: title, isCompleted: false)
        items.append(newItem)
    }
    
    func updateItem(item: TaskModel){  
        if let index = items.firstIndex (where: {$0.id == item.id} ){
            items[index] = item.updateCompletion()
        }
    }
    func saveItems(){
        if let encodedData = try? JSONEncoder().encode(items){
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    
}
