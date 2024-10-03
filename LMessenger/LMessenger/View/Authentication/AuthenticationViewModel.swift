//
//  AuthenticationViewModel.swift
//  LMessenger
//
//  Created by 유연수 on 9/27/24.
//

import Foundation
import Combine
import AuthenticationServices

enum AuthenticationState {
    case unauthenticated
    case authenticated
}

class AuthenticationViewModel: ObservableObject {
    
    enum Action {
        case checkAuthenticationState
        case googleLogin
        case appleLogin(ASAuthorizationAppleIDRequest)
        case appleLoginCompletion(Result<ASAuthorization, Error>)
        case logout
    }
    
    @Published var authenticationState: AuthenticationState = .unauthenticated
    @Published var isLoading = false
    
    var userId: String?
    
    private var container: DIContainer
    // 여러개의 구독 목록을 관리할 Set
    private var subscription = Set<AnyCancellable>()
    private var currentNonce: String?
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func send(action: Action) {
        switch action {
        case .checkAuthenticationState:
            if let userId = container.services.authService.checkAuthenticationState() {
                self.userId = userId
                self.authenticationState = .authenticated
            }
        case .googleLogin:
            isLoading = true
            
            container.services.authService.signInWithGoogle()
                .sink { completion in
                    switch completion {
                    case .finished:
                        self.authenticationState = .authenticated
                    case let .failure(error):
                        self.isLoading = false
                        // TODO: 에러 처리
                        print(error.localizedDescription)
                    }
                } receiveValue: { [weak self] user in
                    self?.isLoading = false
                    self?.userId = user.id
                }.store(in: &subscription)
            return
        case let .appleLogin(request):
            let nonce = container.services.authService.handleSignInWithAppleRequest(request)
            currentNonce = nonce
        case let .appleLoginCompletion(result):
            if case let .success(authorization) = result {
                guard let nonce = currentNonce else { return }
                
                container.services.authService.handleSignInWithAppleCompletion(authorization, nonce: nonce)
                    .sink { completion in
                        switch completion {
                        case .finished:
                            self.authenticationState = .authenticated
                        case let .failure(error):
                            self.isLoading = false
                            // TODO: 에러 처리
                            print(error.localizedDescription)
                        }
                    } receiveValue: { [weak self] user in
                        self?.isLoading = false
                        self?.userId = user.id
                    }.store(in: &subscription)
            } else if case let .failure(error) = result {
                self.isLoading = false
                print(error.localizedDescription)
            }
        case .logout:
            container.services.authService.logout()
                .sink { completion in
                } receiveValue: { [weak self] _ in
                    self?.authenticationState = .unauthenticated
                    self?.userId = nil
                }.store(in: &subscription)
        }
    }
}
