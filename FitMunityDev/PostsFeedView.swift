//
//  PostsFeedView.swift
//  FitMunityDev
//
//  Created by Haoran Jisun on 3/18/25.
//

import SwiftUI

struct PostsFeedView: View {
    // Sample posts data
    @State private var posts: [Post] = Post.samplePosts
    @State private var isRefreshing = false
    @State private var showCreatePost = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Pull to refresh functionality with fixed threshold to prevent accidental activation
                GeometryReader { geometry in
                    if geometry.frame(in: .global).minY > 80 && !isRefreshing {
                        VStack {
                            Spacer()
                            ProgressView()
                                .onAppear {
                                    isRefreshing = true
                                    // Simulate data refresh
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                        self.isRefreshing = false
                                    }
                                }
                            Spacer()
                        }
                        .frame(width: geometry.size.width)
                        .frame(height: 40)
                    } else {
                        Color.clear.frame(height: 0)
                    }
                }
                .frame(height: 0) // Set to 0 height so it doesn't take up space
                
                LazyVStack(spacing: 16) {
                    // Add post and progress indicator row
                    HStack(spacing: 12) {
                        // Add post button
                        AddPostButton {
                            showCreatePost = true
                        }
                        
                        // Progress indicator
                        ProgressIndicatorView(progress: 0.65, goalDate: "3 Aug 2022")
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    
                    // Post content
                    ForEach(posts.prefix(2), id: \.id) { post in
                        VStack(spacing: 0) {
                            postCardFor(post: post)
                                .onTapGesture {
                                    // Handle post tap if needed
                                }
                        }
                        .padding(.bottom, 16)
                    }
                }
                .padding(16)
            }
        }
        .background(Color.gray.opacity(0.1))
        .edgesIgnoringSafeArea(.bottom) // Only ignore bottom safe area
        .sheet(isPresented: $showCreatePost) {
            EditPostView(isPresented: $showCreatePost)
        }
    }
    
    // Helper function to determine which post card to use
    private func postCardFor(post: Post) -> some View {
        Group {
            if post.fitnessInfo != nil {
                // Use expanded post card for posts with fitness info
                ExpandedPostCardView(
                    post: post,
                    onLikeTapped: { likePost(post) },
                    onCommentTapped: { openComments(post) },
                    onShareTapped: { sharePost(post) },
                    onViewCommentsTapped: { openComments(post) }
                )
            } else if post.imageName != nil {
                // Use image post card for posts with images
                ImagePostCard(
                    post: post,
                    onLikeTapped: { likePost(post) },
                    onCommentTapped: { openComments(post) },
                    onShareTapped: { sharePost(post) }
                )
            } else {
                // Use standard post card for text-only posts
                PostCard(
                    post: post,
                    onLikeTapped: { likePost(post) },
                    onCommentTapped: { openComments(post) },
                    onShareTapped: { sharePost(post) }
                )
            }
        }
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 2)
    }
    
    // Action handlers
    private func likePost(_ post: Post) {
        print("Liked post: \(post.id)")
        // Update like count in your data model
    }
    
    private func openComments(_ post: Post) {
        print("Open comments for post: \(post.id)")
        // Navigate to comments view
    }
    
    private func sharePost(_ post: Post) {
        print("Share post: \(post.id)")
        // Show sharing sheet
    }
}

// MARK: - Previews
struct PostsFeedView_Previews: PreviewProvider {
    static var previews: some View {
        PostsFeedView()
    }
}
