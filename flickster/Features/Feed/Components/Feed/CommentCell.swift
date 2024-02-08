import SwiftUI

struct CommentCell: View {
    let time: String
    let comment: String
    let user: String
    let like: String
    let color: Color
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                Circle()
                    .frame(width: 38, height: 38)
                    .foregroundStyle(color)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(user)
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Text(time)
                            .font(.caption)
                            .foregroundColor(.white)
                        
                        /*Button {
                         
                         } label: {
                         Image(systemName: "ellipsis")
                         }
                         .foregroundColor(.white)
                         .buttonStyle(.plain)*/
                    }
                    
                    Text(comment)
                        .font(.subheadline)
                        .lineLimit(5)
                        .multilineTextAlignment(.leading)
                    
                    HStack(spacing: 16) {
                        
                        Text("Reply")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        HStack {
                            Button {} label: {
                                Image(systemName: "heart")
                            }
                            
                            Text(like)
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                        
                        Button {} label: {
                            Image(systemName: "hand.thumbsdown")
                        }
                    }
                    .foregroundColor(.white)
                    .buttonStyle(.plain)
                }
            }
        }
        .background(Color.clear)
    }
}

#Preview {
    CommentCell(time: "", comment: "", user: "", like: "", color: .brown)
}
