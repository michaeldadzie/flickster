import SwiftUI
import UIKit

struct FlicksterTabView: View {
    @EnvironmentObject var launchViewModel: LaunchScreenViewModel
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
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .onAppear {
                    selectedTab = 1
                }
                .tag(1)
            
            ProfileView()
                .tabItem {
                    Image(systemName: selectedTab == 2 ? "person.fill" : "person")
                        .environment(\.symbolVariants, selectedTab == 2 ? .fill : .none)
                    Text("Profile")
                }
                .onAppear {
                    selectedTab = 2
                }
                .tag(2)
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
