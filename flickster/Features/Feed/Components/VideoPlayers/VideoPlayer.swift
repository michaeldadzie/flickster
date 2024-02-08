import SwiftUI
import AVKit

struct VideoPlayer: UIViewRepresentable {
    var player: AVQueuePlayer
    
    class PlayerView: UIView {
        override func layoutSubviews() {
            super.layoutSubviews()
            if let layer = self.layer.sublayers?.first as? AVPlayerLayer {
                layer.frame = self.bounds
            }
        }
    }
    
    func makeUIView(context: Context) -> UIView {
        let view = PlayerView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.frame = view.bounds
        
        view.layer.addSublayer(playerLayer)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        if let playerLayer = (uiView.layer.sublayers?.first as? AVPlayerLayer) {
            playerLayer.player = player
            playerLayer.frame = uiView.bounds
        }
    }
}
