//
//  HomeViewModel.swift
//  LMessenger
//
//  Created by 유연수 on 10/4/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var myUser: User?
    @Published var users: [User] = [User.stub1, User.stub2]
}
