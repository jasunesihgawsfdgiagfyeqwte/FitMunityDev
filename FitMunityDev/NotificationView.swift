//
//  NotificationView.swift
//  FitMunityDev
//
//  Created by Haoran Jisun on 3/18/25.
//

import SwiftUI

struct NotificationView: View {
    @Binding var isPresented: Bool
    
    // MARK: - Properties
    struct NotificationItem: Identifiable {
        let id = UUID()
        let profileImage: String
        let content: String
        let timeAgo: String
        let hasImage: Bool
        let image: String?
        let showMessageButton: Bool
    }
    
    private let notifications = [
        NotificationItem(
            profileImage: "person.crop.circle.fill",
            content: "PH mentioned you in a comment: @PH this looks...",
            timeAgo: "34 min",
            hasImage: true,
            image: "fork.knife.circle.fill",
            showMessageButton: false
        ),
        NotificationItem(
            profileImage: "person.crop.circle.fill",
            content: "PH1, PH2 and 123 others liked your photo.",
            timeAgo: "34 min",
            hasImage: true,
            image: "figure.run.circle.fill",
            showMessageButton: false
        ),
        NotificationItem(
            profileImage: "person.crop.circle.fill",
            content: "PH started following you",
            timeAgo: "6d",
            hasImage: false,
            image: nil,
            showMessageButton: true
        )
    ]
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 0) {
            // Header
            ZStack {
                Color(hex: "FFDD66")
                
                HStack {
                    Button(action: {
                        isPresented = false // Dismiss notification view and return to posts
                    }) {
                        ZStack {
                            Circle()
                                .stroke(Color.black, lineWidth: 1)
                                .frame(width: 36, height: 36)
                            
                            Image(systemName: "chevron.left")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.leading)
                    
                    Text("Notification")
                        .font(.system(size: 24, weight: .medium))
                        .padding(.leading, 8)
                    
                    Spacer()
                }
                .padding(.vertical, 12)
            }
            .frame(height: 56)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Today's notifications
                    Text("new")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.black)
                        .padding(.horizontal)
                        .padding(.top, 16)
                    
                    ForEach(notifications.prefix(2)) { notification in
                        notificationRow(notification)
                    }
                    
                    // This week's notifications
                    Text("this week")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.black)
                        .padding(.horizontal)
                        .padding(.top, 8)
                    
                    ForEach(notifications.suffix(1)) { notification in
                        notificationRow(notification)
                    }
                    
                    Spacer(minLength: 40)
                }
            }
            .background(Color(hex: "FFF8E1"))
            
            // Bottom indicator
            Rectangle()
                .fill(Color.black)
                .frame(width: 134, height: 5)
                .cornerRadius(2.5)
                .padding(.bottom, 8)
        }
        .background(Color(hex: "FFF8E1"))
        .edgesIgnoringSafeArea(.bottom)
    }
    
    // MARK: - Helper Views
    private func notificationRow(_ notification: NotificationItem) -> some View {
        HStack(alignment: .center, spacing: 12) {
            // Profile image
            Image(systemName: notification.profileImage)
                .font(.system(size: 28))
                .foregroundColor(.orange)
                .frame(width: 42, height: 42)
                .background(Color.yellow.opacity(0.3))
                .clipShape(Circle())
            
            // Content
            VStack(alignment: .leading, spacing: 4) {
                Text(notification.content)
                    .font(.system(size: 14))
                    .foregroundColor(.black)
                    .lineLimit(1)
                
                Text(notification.timeAgo)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Optional post image
            if notification.hasImage, let imageName = notification.image {
                Image(systemName: imageName)
                    .font(.system(size: 24))
                    .foregroundColor(.orange)
                    .frame(width: 42, height: 42)
                    .background(Color.yellow.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            // Optional message button
            if notification.showMessageButton {
                Button(action: {
                    // Handle message action
                }) {
                    Text("Message")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.black)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView(isPresented: .constant(true))
    }
}
