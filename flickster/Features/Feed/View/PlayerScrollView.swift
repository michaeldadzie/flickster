import Foundation
import SwiftUI
import AVKit

struct PlayerScrollView: UIViewRepresentable {
    func makeCoordinator() -> PlayerScrollView.Coordinator {
        return PlayerScrollView.Coordinator(parent: self)
    }
    
    @ObservedObject var videoPlayerViewModel: VideoPlayerViewModel
    var post: [Post]
    
    func makeUIView(context: Context) -> UIScrollView {
        let view = UIScrollView()
        
        let childView = UIHostingController(rootView: PlayerView(videoPlayerViewModel: videoPlayerViewModel, post: post))
        childView.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat(post.count))
        
        view.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat(post.count))
        view.addSubview(childView.view)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        
        view.contentInsetAdjustmentBehavior = .never
        view.isPagingEnabled = true
        view.delegate = context.coordinator
        
        return view
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        uiView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat(post.count))
        
        for i in 0..<uiView.subviews.count {
            uiView.subviews[i].frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat(post.count))
        }
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: PlayerScrollView
        var index = 0
        
        init(parent: PlayerScrollView) {
            self.parent = parent
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let currentIndex = Int(scrollView.contentOffset.y / UIScreen.main.bounds.height)
            
            if index != currentIndex {
                index = currentIndex
                
                for _ in 0..<parent.post.count {
                    parent.videoPlayerViewModel.pauseVideo()
                }
                
                parent.videoPlayerViewModel.playVideo(withURL: URL(string: parent.post[index].videoLink)!)
                parent.videoPlayerViewModel.currentPlayer?.actionAtItemEnd = .none
                
                NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: parent.videoPlayerViewModel.currentPlayer?.currentItem, queue: .main) { (_) in
                    self.parent.videoPlayerViewModel.isPlaying = false
                }
            }
        }
    }
}
