import SwiftUI

struct LaunchView: View {
    @EnvironmentObject var viewModel: LaunchViewModel
    @State private var firstPhaseAnimating = false
    @State private var secondPhaseAnimating = false
    
    private let timer = Timer.publish(every: 0.65, on: .main, in: .common).autoconnect()
    
    var body: some View {
        #if !os(visionOS)
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            Image("logo")
                .scaleEffect(firstPhaseAnimating ? 0.6 : 1.0)
                .scaleEffect(secondPhaseAnimating ? UIScreen.main.bounds.size.height / 4 : 1)
        }
        .onReceive(timer) { input in
            switch viewModel.state {
                
            case .first:
                withAnimation(.spring()) {
                    firstPhaseAnimating.toggle()
                }
                
            case .second:
                withAnimation(.easeInOut) {
                    secondPhaseAnimating.toggle()
                }
                
            default: break
            }
        }
        .opacity(secondPhaseAnimating ? 0 : 1)
        #endif
    }
}

#Preview {
    LaunchView()
        .environmentObject(LaunchViewModel())
}
