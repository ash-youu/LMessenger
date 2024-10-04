//
//  MainTabView.swift
//  LMessenger
//
//  Created by 유연수 on 9/30/24.
//

import SwiftUI

struct MainTabView: View {
    @State var selectedTab: MainTabType = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(MainTabType.allCases, id: \.self) { tab in
                Group {
                    switch tab {
                    case .home:
                        HomeView(viewModel: .init())
                    case .chat:
                        ChatView()
                    case .phone:
                        CallView()
                    }
                }
                .tabItem {
                    Label(tab.title,
                          image: tab.imageName(selected: selectedTab == tab))
                }
                .tag(tab)
            }
        }
        .accentColor(.bkText)
    }
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.bkText)
    }
}

#Preview {
    MainTabView()
}
