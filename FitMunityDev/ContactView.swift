import SwiftUI

struct ContactView: View {
    @State private var searchText = ""
    @StateObject private var viewModel = ContactViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            Text("Contact")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top)
            
            // Search bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("search", text: $searchText)
                    .font(.system(size: 16))
            }
            .padding(10)
            .background(Color.white.opacity(0.3))
            .cornerRadius(20)
            .padding(.horizontal)
            .padding(.vertical, 10)
            
            // Contact list
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.filteredContacts(searchText: searchText)) { contact in
                        ContactRow(contact: contact)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
            }
            
            // Removed the tab bar
        }
        .background(Color(hex: "FFF8E1"))
    }
}

struct ContactRow: View {
    let contact: Contact
    @State private var showChatView = false
    
    var body: some View {
        HStack(spacing: 12) {
            // Profile image
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(hex: "FFD54F"))
                    .frame(width: 50, height: 50)
                
                Image("profilePlaceholder")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                
                // Online status indicator
                if contact.online {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 10, height: 10)
                        .overlay(
                            Circle()
                                .stroke(Color(hex: "FFF8E1"), lineWidth: 2)
                        )
                        .offset(x: 20, y: 20)
                }
            }
            
            // Contact info
            VStack(alignment: .leading, spacing: 4) {
                Text(contact.name)
                    .font(.headline)
                
                HStack(spacing: 4) {
                    Text(contact.message)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                    
                    Text("😍")
                        .font(.subheadline)
                }
            }
            
            Spacer()
            
            // Time and notification
            VStack(alignment: .trailing, spacing: 6) {
                Text("\(contact.timeAgo) min")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                ZStack {
                    Circle()
                        .fill(Color.purple)
                        .frame(width: 22, height: 22)
                    
                    Text("\(contact.unreadCount)")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                }
            }
        }
        .padding(.vertical, 8)
        .contentShape(Rectangle())
        .onTapGesture {
            showChatView = true
        }
        .fullScreenCover(isPresented: $showChatView) {
            ChatView(contact: contact)
        }
    }
}

// MARK: - View Model
class ContactViewModel: ObservableObject {
    @Published var contacts: [Contact] = []
    @Published var selectedTab: TabItem = .home
    
    init() {
        self.loadContacts()
    }
    
    private func loadContacts() {
        // In a real app, this would fetch from a data source
        self.contacts = [
            Contact(id: "1", name: "Place Holder", message: "Ad natoque purus habitant nostra.", timeAgo: 34, unreadCount: 3, online: true),
            Contact(id: "2", name: "Place Holder", message: "Ad natoque purus habitant nostra.", timeAgo: 34, unreadCount: 5, online: true),
            Contact(id: "3", name: "Place Holder", message: "Ad natoque purus habitant nostra.", timeAgo: 34, unreadCount: 3, online: false),
            Contact(id: "4", name: "Place Holder", message: "Ad natoque purus habitant nostra.", timeAgo: 34, unreadCount: 8, online: true),
            Contact(id: "5", name: "Place Holder", message: "Ad natoque purus habitant nostra.", timeAgo: 34, unreadCount: 3, online: false),
            Contact(id: "6", name: "Place Holder", message: "Ad natoque purus habitant nostra.", timeAgo: 34, unreadCount: 6, online: true),
        ]
    }
    
    func filteredContacts(searchText: String) -> [Contact] {
        if searchText.isEmpty {
            return contacts
        } else {
            return contacts.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
}

// MARK: - Models
struct Contact: Identifiable {
    let id: String
    let name: String
    let message: String
    let timeAgo: Int
    let unreadCount: Int
    let online: Bool
}

enum TabItem: CaseIterable {
    case home
    case messages
    case favorites
    case profile
    
    var iconName: String {
        switch self {
        case .home: return "house.fill"
        case .messages: return "bubble.left.fill"
        case .favorites: return "heart"
        case .profile: return "person.fill"
        }
    }
}

// MARK: - Preview
struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView()
    }
}
