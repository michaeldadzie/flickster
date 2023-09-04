import AVKit
import SwiftUI

struct VideoView: View {
    
    let post: Post
    @State var player = AVPlayer()
    
    var body: some View {
        NavigationView {
            VStack {
                VideoPlayer(player: player)
                    .frame(width: .infinity, height: .infinity)
                    .onAppear {
                        player = AVPlayer(url: URL(string: post.videoLink)!)
                    }
            }
            .ignoresSafeArea()
        }
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView(post: Post.dummyData)
    }
}
