import SwiftUI

@main
struct FlicksterApp: App {
    @StateObject var viewModel = LaunchScreenViewModel()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                FlicksterTabView()
                
                if viewModel.state != .completed {
                    LaunchScreenView()
                }
            }
            .environmentObject(viewModel)
        }
    }
}
