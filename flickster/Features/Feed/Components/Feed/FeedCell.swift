import AVKit
import SwiftUI

struct FeedCell: View {
    let post: Post
    @Environment(\.openWindow) var openWindow
    
    init(post: Post) {
        self.post = post
    }
    
    var body: some View {
        ZStack {
            if let player = post.player {
                #if !os(visionOS)
                FlicksterPlayer(player: player)
                    .containerRelativeFrame([.horizontal, .vertical])
                #else
                VideoPlayer(player: player)
                    .containerRelativeFrame([.horizontal, .vertical])
                #endif
            }
            VStack {
                Spacer()
                
                HStack(alignment: .bottom) {
                    
                    VStack(alignment: .leading) {
                        Text(post.username)
                            .fontWeight(.semibold)
                            .font(.title)
                        
                        if (!post.title.isEmpty || post.title != "") {
                            Text(post.title)
                            .font(.system(size: 18))
                        }
                    }
                    .foregroundStyle(.white)
                    .font(.subheadline)
                    
                    Spacer()
                    
                    VStack(spacing: 28) {
                        
                        Circle()
                            #if !os(visionOS)
                            .frame(width: 48, height: 48)
                            #endif
                            #if os(visionOS)
                            .frame(width: 70, height: 70)
                            #endif
                            .foregroundStyle(.brown)
                        
                        ActionItem(imageName: "heart.fill", label: "\(post.upvoteCount)") {}
                        
                        ActionItem(imageName: "ellipsis.bubble.fill", label: "\(post.commentCount)") {
                            openWindow(id: "comments")
                        }
                        
                        ActionItem(imageName: "bookmark.fill", label: "0", action: {}, width: 22)
                        
                        ActionItem(imageName: "arrowshape.turn.up.forward.fill", label: "0", action: {})
                        
                    }
                }
                #if os(visionOS)
                .padding(.bottom, 20)
                .padding(.horizontal, 10)
                #endif
                #if !os(visionOS)
                .padding(.bottom, 80)
                #endif
            }
            .padding()
        }
        .onTapGesture {
            if let player = post.player {
                switch player.timeControlStatus {
                case .paused:
                    player.play()
                case .playing:
                    player.pause()
                default:
                    break
                }
            }
        }
    }
}

#Preview {
    FeedCell(post: Post.dummyData.first!)
}
