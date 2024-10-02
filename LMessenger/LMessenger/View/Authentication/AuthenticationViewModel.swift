//
//  AuthenticationViewModel.swift
//  LMessenger
//
//  Created by 유연수 on 9/27/24.
//

import Foundation
import Combine

enum AuthenticationState {
    case unauthenticated
    case authenticated
}

class AuthenticationViewModel: ObservableObject {
    
    enum Action {
        case googleLogin
    }
    
    @Published var authenticationState: AuthenticationState = .unauthenticated
    
    var userId: String?
    
    private var container: DIContainer
    // 여러개의 구독 목록을 관리할 Set
    private var subscription = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func send(action: Action) {
        switch action {
        case .googleLogin:
            container.services.authService.signInWithGoogle()
                .sink { completion in
                    switch completion {
                    case .finished:
                        self.authenticationState = .authenticated
                    case let .failure(error):
                        // TODO: 에러 처리
                        print(error.localizedDescription)
                    }
                } receiveValue: { user in
                    self.userId = user.id
                }.store(in: &subscription)

            return
        }
    }
}
