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
    @Query(filter: #Predicate<User> {user in
        user.name.localizedStandardContains("R") && user.city == "London"
    },sort:\User.name) var users: [User]
    @State private var path = [User]()
    
    var body: some View {
        NavigationStack(path:$path){
            List(users){ user in
                Text(user.name)
            }.navigationTitle("Users")
            
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
            }
        }
        
    }
}

#Preview {
    ContentView()
}
