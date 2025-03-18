//
//  PostInteractionBar.swift
//  FitMunityDev
//
//  Created by Haoran Jisun on 3/18/25.
//

import SwiftUI

// A shared component for the interaction bar at the bottom of posts
struct PostInteractionBar: View {
    @State private var likeCount: Int
    @State private var commentCount: Int
    @State private var isLiked: Bool = false
    @State private var showComments: Bool = false
    
    var onLikeTapped: () -> Void = {}
    var onCommentTapped: () -> Void = {}
    var onShareTapped: () -> Void = {}
    
    // Initialize with like and comment counts
    init(likeCount: Int, commentCount: Int, onLikeTapped: @escaping () -> Void = {}, onCommentTapped: @escaping () -> Void = {}, onShareTapped: @escaping () -> Void = {}) {
        self._likeCount = State(initialValue: likeCount)
        self._commentCount = State(initialValue: commentCount)
        self.onLikeTapped = onLikeTapped
        self.onCommentTapped = onCommentTapped
        self.onShareTapped = onShareTapped
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                
                // Like button with count
                Button(action: {
                    // Toggle like state
                    isLiked.toggle()
                    
                    // Update like count
                    if isLiked {
                        likeCount += 1
                    } else {
                        likeCount -= 1
                    }
                    
                    // Call the provided action
                    onLikeTapped()
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .font(.system(size: 16))
                            .foregroundColor(isLiked ? .red : .black)
                        
                        Text("\(likeCount)")
                            .font(.system(size: 14))
                    }
                }
                .foregroundColor(.black)
                
                Spacer()
                
                // Comment button with count
                Button(action: {
                    // Toggle comments visibility
                    withAnimation(.spring()) {
                        showComments.toggle()
                    }
                    
                    // Call the provided action
                    onCommentTapped()
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: "bubble.left")
                            .font(.system(size: 16))
                        
                        Text("\(commentCount)")
                            .font(.system(size: 14))
                    }
                }
                .foregroundColor(.black)
                
                Spacer()
                
                // Share button (yellow rounded rectangle)
                Button(action: onShareTapped) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                        .frame(width: 32, height: 24) // Smaller size
                        .background(Color(hex: "FFDD66"))
                        .cornerRadius(12)
                }
                
                Spacer()
            }
            .padding(.vertical, 12) // Reduced vertical padding
            .background(Color.white)
            .cornerRadius(24)
            .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 1)
            .padding(.horizontal, 12)
            .padding(.bottom, 6) // Reduced bottom padding
            
            // Comments dropdown section
            if showComments {
                CommentsSection()
                    .padding(.horizontal, 12)
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
    }
}

// Comments dropdown view
struct CommentsSection: View {
    @State private var commentText = ""
    
    // Sample comments data
    private let comments = [
        CommentModel(author: "User1", text: "Great post!", timeAgo: "15m"),
        CommentModel(author: "User2", text: "I love this!", timeAgo: "30m")
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Comments")
                .font(.headline)
                .padding(.top, 8)
            
            // Comments list
            ForEach(comments) { comment in
                HStack(alignment: .top, spacing: 8) {
                    // User avatar
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 32, height: 32)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        HStack {
                            Text(comment.author)
                                .font(.system(size: 14, weight: .medium))
                            
                            Text("•")
                                .foregroundColor(.gray)
                            
                            Text(comment.timeAgo)
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                        
                        Text(comment.text)
                            .font(.system(size: 14))
                    }
                    
                    Spacer()
                }
            }
            
            // Comment input field
            HStack {
                TextField("Add a comment...", text: $commentText)
                    .font(.system(size: 14))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(16)
                
                Button(action: {
                    // Handle post comment
                    commentText = ""
                }) {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 16))
                        .foregroundColor(commentText.isEmpty ? .gray : .black)
                }
                .disabled(commentText.isEmpty)
            }
            .padding(.top, 8)
            .padding(.bottom, 12)
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

// Comment model
struct CommentModel: Identifiable {
    let id = UUID()
    let author: String
    let text: String
    let timeAgo: String
}

// MARK: - Previews
struct PostInteractionBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PostInteractionBar(likeCount: 52, commentCount: 13)
                .padding()
            
            Spacer()
        }
        .background(Color.gray.opacity(0.1))
    }
}
