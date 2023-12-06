import SwiftUI
import UIKit

struct FlicksterTabView: View {
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = .gray
        // UITabBar.appearance().barTintColor = .black
    }
    
    var body: some View {
        TabView {
            FeedView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Feed")
                }
            
            SubverseView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Subverse")
                }
                .onTapGesture {
                    
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
        .accentColor(.red)
    }
}

#Preview {
    FlicksterTabView()
}
