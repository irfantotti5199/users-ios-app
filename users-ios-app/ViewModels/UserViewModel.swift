//
//  UserViewModel.swift
//  users-ios-app
//
//  Created by Irfan on 16/02/26.
//

import Foundation

@MainActor
class UserViewModel {
    private let service: UserServiceProtocol
    private(set) var users: [User] = []
    
    init(service: UserServiceProtocol = UserService()) {
        self.service = service
    }
    
    func fetchUsers() async {
        
        do {
            users = try await service.fetchUsers()
        } catch {
            print("API Failed")
        }
        
    }
}
