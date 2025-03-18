import SwiftUI

struct PostCard: View {
    let post: Post
    var onLikeTapped: () -> Void = {}
    var onCommentTapped: () -> Void = {}
    var onShareTapped: () -> Void = {}
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header with profile info and timestamp
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
                .padding(.bottom, 16)
            
            // Interaction bar
            PostInteractionBar(
                likeCount: post.likeCount,
                commentCount: post.commentCount,
                onLikeTapped: onLikeTapped,
                onCommentTapped: onCommentTapped,
                onShareTapped: onShareTapped
            )
        }
        .background(post.id == "3" ? Color.green.opacity(0.15) : Color(hex: "FFF8DD"))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(post.id == "3" ? Color.green : Color.yellow, lineWidth: 1)
        )
    }
}
