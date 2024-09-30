//
//  LMessengerApp.swift
//  LMessenger
//
//  Created by 유연수 on 9/27/24.
//

import SwiftUI

@main
struct LMessengerApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var container: DIContainer = .init(services: Services())
    
    var body: some Scene {
        WindowGroup {
            AuthenticatedView(authViewModel: .init(container: container))
                .environmentObject(container)
        }
    }
}
