//
//  EditPostView.swift
//  FitMunityDev
//
//  Created by Haoran Jisun on 3/18/25.
//

import SwiftUI
import PhotosUI

struct EditPostView: View {
    @Binding var isPresented: Bool
    @State private var postText: String = ""
    @State private var selectedImage: UIImage?
    @State private var showImagePicker = false
    @State private var showEmojiPicker = false
    @State private var selectedTag: String?
    @State private var tags = ["Fitness", "Nutrition", "Workout", "Recipe", "Progress"]
    @State private var showTagPicker = false
    @FocusState private var isEditorFocused: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
            
            // Main editor container
            VStack(spacing: 0) {
                // Editor card
                VStack(spacing: 0) {
                    // Top toolbar
                    HStack(spacing: 16) {
                        // Edit button
                        HStack(spacing: 4) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.yellow.opacity(0.3))
                                    .frame(width: 40, height: 40)
                                
                                Image(systemName: "pencil")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(.black)
                            }
                            
                            Text("Edit")
                                .font(.system(size: 20, weight: .semibold))
                        }
                        .padding(4)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                .foregroundColor(.yellow)
                        )
                        
                        Spacer()
                        
                        // Send button
                        Button(action: {
                            // Handle post submission
                            submitPost()
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(postText.isEmpty ? Color.gray : Color.yellow)
                                    .frame(width: 50, height: 50)
                                
                                Image(systemName: "paperplane.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                            }
                        }
                        .disabled(postText.isEmpty)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                    
                    // Text editor area
                    ZStack(alignment: .topLeading) {
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                            .foregroundColor(.black)
                            .padding(.horizontal, 20)
                        
                        if postText.isEmpty {
                            Text("Write your post here...")
                                .foregroundColor(.gray.opacity(0.8))
                                .padding(.horizontal, 40)
                                .padding(.top, 20)
                        }
                        
                        VStack {
                            TextEditor(text: $postText)
                                .padding(.horizontal, 30)
                                .background(Color.clear)
                                .frame(height: 200)
                                .focused($isEditorFocused)
                            
                            // Selected image preview
                            if let image = selectedImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 120)
                                    .cornerRadius(12)
                                    .padding(.horizontal, 30)
                                    .padding(.top, 10)
                                    .overlay(
                                        Button(action: {
                                            selectedImage = nil
                                        }) {
                                            Image(systemName: "xmark.circle.fill")
                                                .font(.system(size: 22))
                                                .foregroundColor(.black)
                                                .background(Circle().fill(Color.white))
                                        }
                                        .offset(x: 8, y: -8),
                                        alignment: .topTrailing
                                    )
                            }
                            
                            // Selected tag display
                            if let tag = selectedTag {
                                HStack {
                                    Text("#\(tag)")
                                        .font(.system(size: 16, weight: .medium))
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(Color.yellow.opacity(0.3))
                                        .clipShape(Capsule())
                                    
                                    Button(action: {
                                        selectedTag = nil
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .font(.system(size: 16))
                                            .foregroundColor(.black)
                                    }
                                    
                                    Spacer()
                                }
                                .padding(.horizontal, 40)
                                .padding(.top, 10)
                            }
                        }
                    }
                    
                    // Formatting toolbar
                    HStack(spacing: 16) {
                        Button(action: {
                            // Bold action
                            applyBold()
                        }) {
                            Text("B")
                                .font(.system(size: 22, weight: .bold))
                        }
                        
                        Button(action: {
                            // Align action
                            // This would typically require attributed string support
                        }) {
                            Image(systemName: "text.alignleft")
                                .font(.system(size: 20))
                        }
                        
                        Button(action: {
                            // List action
                            insertBulletPoint()
                        }) {
                            Image(systemName: "list.bullet")
                                .font(.system(size: 20))
                        }
                        
                        Text("|")
                            .foregroundColor(.gray)
                        
                        Button(action: {
                            // Emoji picker
                            showEmojiPicker.toggle()
                            if showEmojiPicker {
                                showTagPicker = false
                                isEditorFocused = false
                            }
                        }) {
                            Image(systemName: "face.smiling")
                                .font(.system(size: 20))
                        }
                        
                        Button(action: {
                            // Image picker
                            showImagePicker = true
                        }) {
                            Image(systemName: "photo")
                                .font(.system(size: 20))
                        }
                        .sheet(isPresented: $showImagePicker) {
                            ImagePicker(selectedImage: $selectedImage)
                        }
                        
                        Text("|")
                            .foregroundColor(.gray)
                        
                        // Tag button
                        Button(action: {
                            // Tag picker
                            showTagPicker.toggle()
                            if showTagPicker {
                                showEmojiPicker = false
                                isEditorFocused = false
                            }
                        }) {
                            Text("# Tag")
                                .font(.system(size: 16, weight: .medium))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(
                                    Capsule()
                                        .stroke(Color.black, lineWidth: 1)
                                )
                        }
                    }
                    .foregroundColor(.black)
                    .padding(.vertical, 20)
                    
                    // Tag picker (conditionally shown)
                    if showTagPicker {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(tags, id: \.self) { tag in
                                    Button(action: {
                                        selectedTag = tag
                                        showTagPicker = false
                                    }) {
                                        Text("#\(tag)")
                                            .font(.system(size: 16))
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 6)
                                            .background(Color.yellow.opacity(0.2))
                                            .cornerRadius(16)
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.bottom, 10)
                        }
                    }
                    
                    // Emoji picker (conditionally shown)
                    if showEmojiPicker {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(["😊", "👍", "💪", "🏋️", "🥗", "🍎", "❤️", "🔥", "👏", "✅"], id: \.self) { emoji in
                                    Button(action: {
                                        insertEmoji(emoji)
                                    }) {
                                        Text(emoji)
                                            .font(.system(size: 24))
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.bottom, 10)
                        }
                    }
                }
                .background(Color(hex: "FFF8E1"))
                .cornerRadius(24)
                .padding(.horizontal)
                
                // Close button at bottom
                Button(action: {
                    isPresented = false
                }) {
                    ZStack {
                        Circle()
                            .fill(Color(hex: "FF9EB1"))
                            .frame(width: 60, height: 60)
                        
                        Image(systemName: "xmark")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                .offset(y: -30)
                .padding(.bottom, -30)
            }
            .padding(.vertical)
        }
    }
    
    // MARK: - Helper Functions
    
    private func applyBold() {
        // In a real app, this would manipulate NSAttributedString
        // For this example, we'll just add ** around the selected text
        let selectedText = UITextView().selectedTextRange
        // This is a simplified implementation
        postText += "**Bold Text**"
    }
    
    private func insertBulletPoint() {
        postText += "\n• "
    }
    
    private func insertEmoji(_ emoji: String) {
        postText += emoji
        showEmojiPicker = false
        isEditorFocused = true
    }
    
    private func submitPost() {
        // In a real app, this would save the post to a database
        print("Post submitted: \(postText)")
        
        // Close the editor
        isPresented = false
    }
}

// MARK: - Image Picker

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) private var presentationMode
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.presentationMode.wrappedValue.dismiss()
            
            guard let provider = results.first?.itemProvider else { return }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, error in
                    DispatchQueue.main.async {
                        self.parent.selectedImage = image as? UIImage
                    }
                }
            }
        }
    }
}

// MARK: - Preview
struct EditPostView_Previews: PreviewProvider {
    static var previews: some View {
        EditPostView(isPresented: .constant(true))
    }
}
