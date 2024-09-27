//
//  LMessengerApp.swift
//  LMessenger
//
//  Created by 유연수 on 9/27/24.
//

import SwiftUI

@main
struct LMessengerApp: App {
    @StateObject var container: DIContainer = .init(services: Services())
    
    var body: some Scene {
        WindowGroup {
            AuthenticatedView(authViewModel: .init())
                .environmentObject(container)
        }
    }
}
