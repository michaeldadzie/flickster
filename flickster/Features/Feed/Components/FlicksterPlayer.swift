import AVKit
import SwiftUI
import AVFoundation

struct FlicksterPlayer: UIViewControllerRepresentable {
    var player: AVPlayer
    
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        controller.exitsFullScreenWhenPlaybackEnds = true
        controller.allowsPictureInPicturePlayback = true
        controller.videoGravity = .resizeAspectFill
        
        /*if let currentItem = player.currentItem {
            let _ = AVPlayerLooper(player: player, templateItem: currentItem)
        }*/
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
