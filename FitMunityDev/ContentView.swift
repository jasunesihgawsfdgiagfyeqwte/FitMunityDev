//
//  ContentView.swift
//  FitMunityDev
//
//  Created by Haoran Jisun on 3/18/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Standard post card
                PostCard(post: Post.samplePosts[0])
                
                // Image post card
                ImagePostCard(post: Post.samplePosts[1])
                
                // Expanded post card with fitness info
                ExpandedPostCardView(post: Post.samplePosts[2])
            }
            .padding(16)
        }
        .background(Color.gray.opacity(0.1))
    }
}
