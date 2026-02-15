//
//  UserView.swift
//  SwiftDataProject
//
//  Created by Mohit Sengar on 04/02/26.
//

import SwiftUI
import SwiftData

struct UserView: View {
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]
    
    var body: some View {
        List(users){ user in
            HStack{
                Text(user.name)
                
                Spacer()
                
                Text(String(user.jobs.count))
                    .fontWeight(.black)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
            }
        }.onAppear(perform: addSamples)
    }
    
    init(minimumJoinDate: Date, sortOrder: [SortDescriptor<User>]){
        _users = Query(filter: #Predicate<User> {user in
            user.joinDate >= minimumJoinDate
        },sort: sortOrder)
    }
    
    func addSamples(){
        let user1 = User(name: "Charley Chaplin", city: "Noida", joinDate: .now)
        let job1 = Job(name: "Create Car Model", priority: 5)
        let job2 = Job(name: "Design the prototype", priority: 3)
        
        modelContext.insert(user1)
        
        user1.jobs.append(job1)
        user1.jobs.append(job2)
    }
}

#Preview {
    UserView(minimumJoinDate: .now, sortOrder: [SortDescriptor(\User.name)]).modelContainer(for: User.self)
}
