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
    
    private let limit = 3
    private var currentPage = 1
    private var isLoading = false
    
    
    init(service: UserServiceProtocol = UserService()) {
        self.service = service
    }
    
    func fetchInitialUsers() async {
        currentPage = 1
        users.removeAll()
        await loadMore()
    }
    
    func loadMore() async {
        
        guard !isLoading else {return}
        isLoading = true
        
        do {
            
            let newData = try await service.fetchUsers(page: currentPage, limit: limit)
            if !users.isEmpty {
                users.append(contentsOf: newData)
                currentPage += 1
            }
            
            
        } catch {
            print("API Failed")
        }
        isLoading = false
        
    }
}
