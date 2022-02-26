//
//  TaskView.swift
//  HarshulAndMike
//
//  Created by Harshul Jain on 1/25/22.
//

import SwiftUI

struct TaskView: View {
    @EnvironmentObject var taskViewModel: TaskViewModel
    @EnvironmentObject var pause: RestingTime
    @State private var rest: Bool = false;
    
    var body: some View {
        VStack{
            if taskViewModel.items.isEmpty{
                noItemsView()
            } else {
                List{
                    ForEach(taskViewModel.items) { item in
                        TaskRowView(item: item)
                            .onTapGesture {
                                withAnimation(.linear){
                                    taskViewModel.updateItem(item: item)
                                }
                            }
                    }
                    .onDelete(perform: taskViewModel.deleteTask)
                    .onMove(perform: taskViewModel.moveItem)
                    
                }
                .frame(height: 600.0)
                .listStyle(PlainListStyle())
                
            }
            VStack{
                Spacer()
                NavigationLink(
                    destination: TimerView(),
                    label: {
                        Text("Pomodoro Timer ⏰")
                            
                            .foregroundColor(.white)
                            .font(.title3)
                            .bold()
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.accentColor)
                            .cornerRadius(15)
                    })
                    .multilineTextAlignment(.center)
                    .padding(30)
            }
            
        }
        
        .navigationTitle("Todo List 📝")
        .navigationBarItems(
            leading: EditButton(),
            trailing:
                NavigationLink("Add", destination: AddView())
        )
    }
    
/*    func changerest(rest: Bool){
        if (self.rest == true){
            self.rest = false
        } else if (self.rest == false){
            self.rest = true
        }
    }
*/
 
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            TaskView()
        }
        .environmentObject(TaskViewModel())
    }
}

