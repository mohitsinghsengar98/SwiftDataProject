//
//  UserView.swift
//  SwiftDataProject
//
//  Created by Mohit Sengar on 04/02/26.
//

import SwiftUI
import SwiftData

struct UserView: View {
    @Query var users: [User]
    
    var body: some View {
        List(users){ user in
            Text(user.name)
        }
    }
    
    init(minimumJoinDate: Date, sortOrder: [SortDescriptor<User>]){
        _users = Query(filter: #Predicate<User> {user in
            user.joinDate >= minimumJoinDate
        },sort: sortOrder)
    }
}

#Preview {
    UserView(minimumJoinDate: .now, sortOrder: [SortDescriptor(\User.name)]).modelContainer(for: User.self)
}
