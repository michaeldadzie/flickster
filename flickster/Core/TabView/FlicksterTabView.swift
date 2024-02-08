import SwiftUI
import UIKit

struct FlicksterTabView: View {
    @EnvironmentObject var launchViewModel: LaunchViewModel
    @State private var selectedTab = 0
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = .gray
        UITabBar.appearance().tintColor = .red
        UITabBar.appearance().barTintColor = .black
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            FeedView()
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                        .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
                    Text("Home")
                }
                .onAppear { selectedTab = 0 }
                .tag(0)
            
            SubverseView()
                .tabItem {
                    Image(systemName: selectedTab == 1 ? "person.2.fill" : "person.2")
                        .environment(\.symbolVariants, selectedTab == 1 ? .fill : .none)
                    Text("Friends")
                }
                .onAppear { selectedTab = 1 }
                .tag(1)
            
            SubverseView()
                .tabItem {
                    Image(systemName: selectedTab == 2 ? "plus.app.fill" : "plus.app")
                        .environment(\.symbolVariants, selectedTab == 2 ? .fill : .none)
                    Text("Post")
                }
                .onAppear { selectedTab = 2 }
                .tag(2)
            
            SubverseView()
                .tabItem {
                    Image(systemName: selectedTab == 3 ? "text.bubble.fill" : "text.bubble")
                        .environment(\.symbolVariants, selectedTab == 3 ? .fill : .none)
                    Text("Inbox")
                }
                .onAppear { selectedTab = 3 }
                .tag(3)
            
            ProfileView()
                .tabItem {
                    Image(systemName: selectedTab == 4 ? "person.fill" : "person")
                        .environment(\.symbolVariants, selectedTab == 4 ? .fill : .none)
                    Text("Profile")
                }
                .onAppear { selectedTab = 4 }
                .tag(4)
        }
        .onAppear {
            DispatchQueue
                .main
                .asyncAfter(deadline: .now() + 1) {
                    launchViewModel.dismiss()
                }
        }
    }
}

#Preview {
    FlicksterTabView()
}
