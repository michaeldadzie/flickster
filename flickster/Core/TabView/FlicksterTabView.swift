import SwiftUI
import UIKit

struct FlicksterTabView: View {
    @State private var selectedTab = 0
    @StateObject var manager = FlicksterManager()
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = .gray
        // UITabBar.appearance().barTintColor = .black
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
                    Image(systemName: "magnifyingglass")
                    Text("Subverse")
                }
                .onAppear { 
                    selectedTab = 1
                }
                .tag(1)
                // .onTapGesture { manager.player.pause() }
            
            ProfileView()
                .tabItem {
                    Image(systemName: selectedTab == 2 ? "person.fill" : "person")
                        .environment(\.symbolVariants, selectedTab == 2 ? .fill : .none)
                    Text("Profile ")
                }
                .onAppear { 
                    selectedTab = 2
                }
                .tag(2)
                // .onTapGesture { manager.player.pause() }
        }
        .tint(.red)
    }
}

#Preview {
    FlicksterTabView()
}
