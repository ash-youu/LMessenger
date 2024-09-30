//
//  AuthenticationViewModel.swift
//  LMessenger
//
//  Created by 유연수 on 9/27/24.
//

import Foundation

enum AuthenticationState {
    case unauthenticated
    case authenticated
}

class AuthenticationViewModel: ObservableObject {
    
    @Published var authenticationState: AuthenticationState = .unauthenticated
    private var container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
}
