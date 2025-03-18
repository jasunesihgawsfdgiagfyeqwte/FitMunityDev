import SwiftUI

struct ChatView: View {
    let contact: Contact
    @State private var messageText = ""
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = ChatViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Background color
            Color(hex: "FFF8E1").edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // Chat header
                HStack(spacing: 12) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left.circle")
                            .font(.system(size: 24))
                            .foregroundColor(.black)
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(hex: "FFD54F"))
                            .frame(width: 40, height: 40)
                        
                        Image("profilePlaceholder")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                        
                        // Online status indicator
                        if contact.online {
                            Circle()
                                .fill(Color.green)
                                .frame(width: 8, height: 8)
                                .overlay(
                                    Circle()
                                        .stroke(Color(hex: "FFF8E1"), lineWidth: 2)
                                )
                                .offset(x: 16, y: 16)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(contact.name)
                            .font(.headline)
                        
                        Text("p_h")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // Show more options
                    }) {
                        Image(systemName: "ellipsis")
                            .font(.system(size: 22))
                            .foregroundColor(.black)
                            .rotationEffect(.degrees(90))
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
                .padding(.bottom, 10)
                .background(Color(hex: "FFF8E1"))
                
                // Time indicator
                HStack {
                    Spacer()
                    Text("today 14:20")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding(.top, 8)
                
                // Chat messages
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.messages) { message in
                            MessageView(message: message)
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                }
                
                Spacer(minLength: 60) // Space for the message input
            }
            
            // Message input at bottom
            HStack(spacing: 12) {
                Button(action: {
                    // Show image picker
                }) {
                    Image(systemName: "photo")
                        .font(.system(size: 22))
                        .foregroundColor(.gray)
                }
                
                TextField("Tap a message...", text: $messageText)
                    .padding(10)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(20)
                
                Button(action: {
                    // Send message
                    sendMessage()
                }) {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 20))
                        .foregroundColor(Color.black.opacity(0.7))
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
            .background(Color(hex: "FFDD66"))
        }
        .navigationBarHidden(true)
    }
    
    private func sendMessage() {
        if !messageText.isEmpty {
            viewModel.sendMessage(content: messageText)
            messageText = ""
        }
    }
}

struct MessageView: View {
    let message: ChatMessage
    
    var body: some View {
        HStack {
            if message.isFromCurrentUser {
                Spacer()
                
                Text(message.content)
                    .padding(12)
                    .background(Color.white)
                    .cornerRadius(16)
                    .overlay(
                        message.emoji != nil ? Text(message.emoji ?? "")
                            .font(.system(size: 16))
                            .offset(x: 0, y: 24) : nil
                    )
            } else {
                HStack(alignment: .bottom, spacing: 8) {
                    // Profile image for non-user messages
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(hex: "FFD54F"))
                            .frame(width: 30, height: 30)
                        
                        Image("profilePlaceholder")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                    
                    Text(message.content)
                        .padding(12)
                        .background(Color(hex: "F5E4C3"))
                        .cornerRadius(16)
                        .overlay(
                            message.emoji != nil ? Text(message.emoji ?? "")
                                .font(.system(size: 16))
                                .offset(x: 0, y: 24) : nil
                        )
                }
                
                Spacer()
            }
        }
        .padding(.bottom, message.emoji != nil ? 20 : 0)  // Add padding if emoji exists
    }
}

// MARK: - Models
struct ChatMessage: Identifiable {
    let id = UUID()
    let content: String
    let isFromCurrentUser: Bool
    let timestamp: Date
    let emoji: String?
}

// MARK: - ViewModel
class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    
    init() {
        loadMessages()
    }
    
    private func loadMessages() {
        messages = [
            ChatMessage(
                content: "Lorem ipsum odor amet, consectetuer adipiscing elit. Magna tortor risus purus orci mauris congue scelerisque eleifend sit.",
                isFromCurrentUser: false,
                timestamp: Date().addingTimeInterval(-3600),
                emoji: nil
            ),
            ChatMessage(
                content: "Imperdiet nullam facilisis fermentum ridiculus varius sollicitudin. Litora morbi orci cubilia rutrum laoreet erat arcu dolor.",
                isFromCurrentUser: true,
                timestamp: Date().addingTimeInterval(-3000),
                emoji: nil
            ),
            ChatMessage(
                content: "Commodo condimentum molestie taciti risus ipsum dignissim; curabitur porta facilisi.",
                isFromCurrentUser: false,
                timestamp: Date().addingTimeInterval(-2400),
                emoji: nil
            ),
            ChatMessage(
                content: "Tristique vestibulum tempor fermentum, placerat sollicitudin natoque curabitur fringilla netus arcu sed torquent.",
                isFromCurrentUser: true,
                timestamp: Date().addingTimeInterval(-1800),
                emoji: nil
            ),
            ChatMessage(
                content: "Fringilla erat magnis integer massa.",
                isFromCurrentUser: true,
                timestamp: Date().addingTimeInterval(-1200),
                emoji: nil
            ),
            ChatMessage(
                content: "Nisl eget dapibus metus",
                isFromCurrentUser: false,
                timestamp: Date().addingTimeInterval(-600),
                emoji: "😍"
            ),
            ChatMessage(
                content: "Ad natoque purus habitant nostra.",
                isFromCurrentUser: true,
                timestamp: Date().addingTimeInterval(-300),
                emoji: "😍"
            ),
            ChatMessage(
                content: "Quisque lectus dapibus consequat.",
                isFromCurrentUser: true,
                timestamp: Date(),
                emoji: "😍"
            )
        ]
    }
    
    func sendMessage(content: String) {
        let newMessage = ChatMessage(
            content: content,
            isFromCurrentUser: true,
            timestamp: Date(),
            emoji: nil
        )
        messages.append(newMessage)
    }
}

// MARK: - Preview
struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(contact: Contact(
            id: "1",
            name: "Place Holder",
            message: "Ad natoque purus habitant nostra.",
            timeAgo: 34,
            unreadCount: 3,
            online: true
        ))
    }
}
