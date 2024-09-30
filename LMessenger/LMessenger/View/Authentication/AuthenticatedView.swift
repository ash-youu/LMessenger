//
//  AuthenticatedView.swift
//  LMessenger
//
//  Created by 유연수 on 9/27/24.
//

import SwiftUI

struct AuthenticatedView: View {
    @StateObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        switch authViewModel.authenticationState {
        case .unauthenticated:
            LoginIntroView()
        case .authenticated:
            MainTabView()
        }
    }
}

#Preview {
    AuthenticatedView(authViewModel: .init(container: .init(services: StubService())))
}
