//
//  ExpandedPostCardView.swift
//  FitMunityDev
//
//  Created by Haoran Jisun on 3/18/25.
//

import SwiftUI

struct ExpandedPostCardView: View {
    let post: Post
    var onLikeTapped: () -> Void = {}
    var onCommentTapped: () -> Void = {}
    var onShareTapped: () -> Void = {}
    var onViewCommentsTapped: () -> Void = {}
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header with profile info
            HStack {
                Text("My story")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Spacer()
                
                Text("2025 - 03 - 06 11:30:00")
                    .font(.caption2)
                    .foregroundColor(.gray)
                
                Button(action: {}) {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .padding(.bottom, 8)
            
            // Post content
            Text(post.content)
                .font(.subheadline)
                .padding(.horizontal, 16)
                .padding(.bottom, 12)
            
            // Post image
            if let imageName = post.imageName {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .frame(height: 240)
                    .clipped()
            }
            
            // Interaction bar
            PostInteractionBar(
                likeCount: post.likeCount,
                commentCount: post.commentCount,
                onLikeTapped: onLikeTapped,
                onCommentTapped: onCommentTapped,
                onShareTapped: onShareTapped
            )
            
            // Fitness coach info
            if let fitnessInfo = post.fitnessInfo {
                Divider()
                    .background(Color.red.opacity(0.5))
                    .padding(.horizontal, 16)
                
                HStack(alignment: .top, spacing: 8) {
                    Text("Your personal fitness coach:")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.red)
                    
                    Text("\"\(fitnessInfo)\"")
                        .font(.caption)
                        .foregroundColor(.black.opacity(0.8))
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)
                .padding(.bottom, 4)
                
                // Hashtags
                HStack {
                    Text("#beef")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.pink)
                    
                    Text("#Calorie")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.pink)
                    
                    Text("#awesome")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.pink)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
            }
            
            // Comments section
            HStack {
                Button(action: onViewCommentsTapped) {
                    Text("View all comments (\(post.commentCount))")
                        .font(.caption)
                        .foregroundColor(.red)
                }
                
                Spacer()
                
                HStack(spacing: 4) {
                    Image(systemName: "clock")
                        .font(.system(size: 12))
                    
                    Text("\(post.timeAgo) ago")
                        .font(.caption)
                }
                .foregroundColor(.gray)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .background(Color(hex: "FFF8DD"))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.yellow, lineWidth: 1)
        )
        
        // Add the interaction bar as a separate element outside the card
        // to create the floating card effect
        PostInteractionBar(
            likeCount: post.likeCount,
            commentCount: post.commentCount,
            onLikeTapped: onLikeTapped,
            onCommentTapped: onCommentTapped,
            onShareTapped: onShareTapped
        )
    }
}
