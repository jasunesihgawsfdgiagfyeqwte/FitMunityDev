import SwiftUI

// Main Post model used throughout the app
struct Post {
    let id: String
    let content: String
    let likeCount: Int
    let commentCount: Int
    let imageName: String?
    let timeAgo: String
    let fitnessInfo: String?
    
    static var samplePosts: [Post] = [
        Post(
            id: "1",
            content: "Today I've got some beef :)",
            likeCount: 52,
            commentCount: 13,
            imageName: nil,
            timeAgo: "3h",
            fitnessInfo: nil
        ),
        Post(
            id: "2",
            content: "Today I've got some beef :)",
            likeCount: 52,
            commentCount: 13,
            imageName: "beefSoup",
            timeAgo: "3h",
            fitnessInfo: nil
        ),
        Post(
            id: "3",
            content: "Today I've got some beef :)",
            likeCount: 52,
            commentCount: 13,
            imageName: "beefSoup",
            timeAgo: "3h",
            fitnessInfo: "Perfect post-workout fuel! 👍 Beef soup packs <300 cal per bowl, rich in protein & nutrients! 🌟 #Beef #Calorie #awesome"
        )
    ]
}
