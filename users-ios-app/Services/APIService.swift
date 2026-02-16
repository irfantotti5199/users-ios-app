//
//  APIService.swift
//  users-ios-app
//
//  Created by Irfan on 16/02/26.
//

import Foundation

protocol UserServiceProtocol {
    func fetchUsers() async throws -> [User]
}

final class UserService: UserServiceProtocol {
    func fetchUsers() async throws -> [User] {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        return try JSONDecoder().decode([User].self, from: data)
    }
}
