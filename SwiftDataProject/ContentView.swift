//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Mohit Sengar on 20/12/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var path = [User]()
    @State private var isShowingUpcomingOnly = false
    @State private var sortOrder = [
        SortDescriptor(\User.name),SortDescriptor(\User.joinDate)
    ]
    
    var body: some View {
        NavigationStack(path:$path){
            UserView(minimumJoinDate: isShowingUpcomingOnly ? .now : .distantPast,sortOrder: sortOrder).navigationTitle("Users")
            .toolbar{
                Button("Add User", systemImage: "plus"){
                    try? modelContext.delete(model: User.self)
                    let first = User(name: "Ed shereen", city: "London", joinDate: .now.addingTimeInterval(86400 * -10))
                    let second = User(name: "Rosa Diaz", city: "New York", joinDate: .now.addingTimeInterval(86400 * -5))
                    let third = User(name: "Roy kent", city: "London", joinDate: .now.addingTimeInterval(86400 * 5))
                    let fourth = User(name: "Jonny English", city: "London", joinDate: .now.addingTimeInterval(86400 * 10))
                    
                    modelContext.insert(first)
                    modelContext.insert(second)
                    modelContext.insert(third)
                    modelContext.insert(fourth)
                }
                
                Button(isShowingUpcomingOnly ? "Show Everyone" : "Show Upcoming"){
                    isShowingUpcomingOnly.toggle()
                }
                
                Menu("Sort", systemImage: "arrow.up.arrow.down"){
                    Picker("Sort", selection:$sortOrder){
                        Text("Sort by Name").tag([SortDescriptor(\User.name),SortDescriptor(\User.joinDate)])
                        Text("Sort by Join date").tag([SortDescriptor(\User.joinDate),SortDescriptor(\User.name)])
                    }
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}
