import Foundation

final class LaunchViewModel: ObservableObject {
    
    @Published private(set) var state: LaunchScreenPhase = .first
    
    func dismiss() {
        self.state = .second
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.state = .completed
        }
    }
}
