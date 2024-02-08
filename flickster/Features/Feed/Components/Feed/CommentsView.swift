import SwiftUI

struct CommentsView: View {
    @State private var comment = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    CommentCell(time: "3d", comment: "Those whow use/develop their gifts will be rewarded with even more, while those who don't utilize their blessing will lose even what they have.❤️", user: "paul", like: "16", color: .blue)
                    CommentCell(time: "1d", comment: "and whoever has the will & hideth it, shall be forever shamed", user: "giovanni", like: "1", color: .purple)
                    CommentCell(time: "1d", comment: "beautiful beautiful :)", user: "jesusinlove", like: "3", color: .red)
                    CommentCell(time: "2d", comment: "amen and bless you from holland🥰🥰🥰", user: "van der beek", like: "0", color: .green)
                    CommentCell(time: "3d", comment: "amen", user: "demi", like: "0", color: .yellow)
                    CommentCell(time: "3d", comment: "Amen🙏🏾", user: "jazzy", like: "1", color: .blue)
                    CommentCell(time: "3d", comment: "Amen🙏🏻", user: "patricia", like: "1", color: .black)
                }
                
                TextField("Add a comment...", text: $comment)
                    .padding()
                    .cornerRadius(5)
            }
            .padding(.horizontal)
            .navigationTitle("7 comments")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    CommentsView()
}
