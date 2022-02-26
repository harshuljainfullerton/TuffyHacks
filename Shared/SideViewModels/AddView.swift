//
//  AddView.swift
//  HarshulAndMike
//
//  Created by Harshul Jain on 1/25/22.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var taskViewModel: TaskViewModel
    @State var text: String = ""
    @State var alert: String = ""
    @State var showAlert: Bool = false
    
    var body: some View {
        ScrollView{
            VStack{
                TextField("Type something here...", text: $text)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                    .cornerRadius(15)
                
                Button(action: {
                    saveButtonPress()
                }, label: {
                    Text("SAVE")
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(width: 400)
                        .font(.headline)
                        .background(Color.accentColor)
                        .cornerRadius(15)
                })
            }
            .padding(15)
        }
        .navigationTitle("Add a Task ✏️")
        .alert(isPresented: $showAlert, content: getAlert)
        
    }
    func saveButtonPress() {
        if (checkText()){
            taskViewModel.addItem(title: text)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func checkText() -> Bool{
        if(text.count <= 1){
            alert = "Your new task must be more than 1 character long!!!        😱😱😱"
            showAlert.toggle()
            return false
        }
        else{
            return true
        }
    }
    
    func getAlert () -> Alert{
        return Alert(title: Text(alert))
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddView()
        }
        .environmentObject(TaskViewModel())
    }
}
