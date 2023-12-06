import AVKit
import SwiftUI

struct FeedCell: View {
    let post: Post
    var player: AVPlayer
    
    init(post: Post, player: AVPlayer) {
        self.post = post
        self.player = player
    }
    
    var body: some View {
        ZStack {
            FlicksterPlayer(player: player)
                .containerRelativeFrame([.horizontal, .vertical])
            
            VStack {
                Spacer()
                
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading) {
                        Text("michaeldadzie")
                            .fontWeight(.semibold)
                        Text("Prepare pulse for iOS 17")
                    }
                    .foregroundStyle(.white)
                    .font(.subheadline)
                    
                    Spacer()
                    
                    VStack(spacing: 28) {
                        
                        Circle()
                            .frame(width: 48, height: 48)
                            .foregroundStyle(.yellow)
                        
                        ActionItem(imageName: "heart.fill", label: "27", action: {})
                        
                        ActionItem(imageName: "ellipsis.bubble.fill", label: "2", action: {})
                        
                        ActionItem(imageName: "bookmark.fill", label: "0", action: {}, width: 22)
                        
                        ActionItem(imageName: "arrowshape.turn.up.forward.fill", label: "Share", action: {})
                
                    }
                }
                .padding(.bottom, 80)
            }
            .padding()
        }
        .onTapGesture {
            switch player.timeControlStatus {
            case .paused:
                player.play()
            case .waitingToPlayAtSpecifiedRate:
                break
            case .playing:
                player.pause()
            @unknown default:
                break
            }
        }
    }
}

#Preview {
    FeedCell(post: Post.dummyData.first!, player: AVPlayer())
}
