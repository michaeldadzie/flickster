import SwiftUI

@main
struct FlicksterApp: App {
    @StateObject var viewModel = LaunchViewModel()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                FlicksterTabView()
                
                if viewModel.state != .completed {
                    LaunchView()
                }
            }
            .environmentObject(viewModel)
        }
        #if os(visionOS)
        .defaultSize(CGSize(width: 600, height: 1000))
        #endif
        WindowGroup(id: "comments") {
            CommentsView()
        }
        #if os(visionOS)
        .defaultSize(CGSize(width: 500, height: 750))
        #endif
    }
}
