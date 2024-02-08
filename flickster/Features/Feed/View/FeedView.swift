import SwiftUI

struct FeedView: View {
    @StateObject var viewModel = FeedViewModel(service: FeedService())
    
    var body: some View {
        ZStack {
            #if !os(visionOS)
            Color.black
                .ignoresSafeArea()
            #endif
            
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(viewModel.posts) { post in
                        FeedCell(post: post).id(post.id)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollIndicators(.hidden)
            .scrollPosition(id: $viewModel.scrollPosition)
            .scrollTargetBehavior(.paging)
            .ignoresSafeArea()
            //.task { await viewModel.getPosts() }
            .onAppear {Task { await viewModel.getPosts() }}
            .onChange(of: viewModel.scrollPosition) { previousIndex, currentIndex in
                viewModel.onChanged(previousID: previousIndex, currentID: currentIndex)
            }
            
        }
    }
}

#Preview {
    FeedView()
}
