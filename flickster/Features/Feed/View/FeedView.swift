import AVKit
import SwiftUI

struct FeedView: View {
    //@StateObject var manager = FlicksterManager(viewModel: FeedViewModelImpl(service: FeedServiceImpl()))
    @StateObject var viewModel = FeedViewModelImpl(service: FeedServiceImpl())
    @State private var hasLoadedPosts = false
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(viewModel.posts) { post in
                    FeedCell(post: post)
                        .id(post.id)
                }
            }
            .scrollTargetLayout()
        }
        .scrollIndicators(.hidden)
        .scrollPosition(id: $viewModel.scrollPosition)
        .scrollTargetBehavior(.paging)
        .ignoresSafeArea()
        .task { await viewModel.getPosts() }
        .onChange(of: viewModel.scrollPosition) { previousIndex, currentIndex in
            viewModel.onChanged(previousID: previousIndex, currentID: currentIndex)
        }
    }
}

#Preview {
    FeedView()
}
