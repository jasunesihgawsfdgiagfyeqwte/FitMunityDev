//
//  ImagePostCard.swift
//  FitMunityDev
//
//  Created by Haoran Jisun on 3/18/25.
//

import SwiftUI

struct ImagePostCard: View {
    let post: Post
    var onLikeTapped: () -> Void = {}
    var onCommentTapped: () -> Void = {}
    var onShareTapped: () -> Void = {}
    
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
                    .frame(height: 200)
                    .clipped()
                    .padding(.bottom, 12)
            }
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
