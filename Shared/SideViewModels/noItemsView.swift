//
//  noItemsView.swift
//  HarshulAndMike
//
//  Created by Harshul Jain on 1/25/22.
//

import SwiftUI

struct noItemsView: View {
    @EnvironmentObject var pause: RestingTime
    var body: some View {
        ScrollView{
            VStack(spacing:10){
                Text("There are no Tasks!")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("Want to get work done fast? Want to have a place to store all the things you need to do? Look no further! 🥳")
                Text("Be sure to check out the Pomodoro Timer!! ⏳")
                NavigationLink(
                    destination: AddView(),
                    label: {
                        Text("Add Tasks! 🤓")
                            
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.accentColor)
                            .cornerRadius(15)
                    })
            }
            .multilineTextAlignment(.center)
            .padding(30)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
    }
}

struct noItemsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            noItemsView()
                .navigationTitle("No Items :(")
        }
    }
}
