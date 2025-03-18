//
//  MainAppView.swift
//  FitMunityDev
//

import SwiftUI

struct MainAppView: View {
    @State private var selectedTab = 0 // Home tab selected by default
    @State private var showCreatePost = false
    @State private var showNotifications = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Content based on selected tab
            VStack(spacing: 0) {
                // Tab content
                tabContent
                
                Spacer(minLength: 70) // Space for the tab bar
            }
            
            // Custom tab bar at the bottom
            CustomTabBar(
                selectedTab: $selectedTab,
                onAddTapped: {
                    // Action for the add button
                    showCreatePost = true
                }
            )
        }
        .sheet(isPresented: $showCreatePost) {
            EditPostView(isPresented: $showCreatePost)
        }
    }
    
    // Tab content based on selected tab index
    private var tabContent: some View {
        Group {
            switch selectedTab {
            case 0:
                // Home tab
                NavigationView {
                    ZStack(alignment: .top) {
                        // Main content
                        PostsFeedView()
                            .padding(.top, 60) // Add padding for the custom header
                        
                        // Custom header
                        VStack(spacing: 0) {
                            // Status bar color
                            Color(hex: "FFF8E1")
                                .frame(height: 0) // Takes up status bar space
                                .edgesIgnoringSafeArea(.top)
                            
                            // Custom header content
                            HStack(alignment: .center) {
                                Text("Posts")
                                    .font(.system(size: 34, weight: .bold))
                                    .foregroundColor(.black)
                                
                                Spacer()
                                
                                Button(action: {
                                    // Navigate to notification view
                                    showNotifications = true
                                }) {
                                    Image(systemName: "envelope")
                                        .font(.system(size: 24))
                                        .foregroundColor(.black)
                                        .frame(width: 44, height: 44)
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                            .background(Color(hex: "FFF8E1"))
                        }
                    }
                    .navigationBarHidden(true) // Hide the default navigation bar
                    .fullScreenCover(isPresented: $showNotifications) {
                        NotificationView(isPresented: $showNotifications)
                    }
                }
                .navigationViewStyle(StackNavigationViewStyle())
                
            case 1:
                // Messages tab - now shows ContactView
                NavigationView {
                    ContactView()
                        .navigationBarHidden(true)
                }
                .navigationViewStyle(StackNavigationViewStyle())
                
            case 2:
                // Home/Feed tab (default)
                NavigationView {
                    ZStack(alignment: .top) {
                        // Main content
                        PostsFeedView()
                            .padding(.top, 60) // Add padding for the custom header
                        
                        // Custom header
                        VStack(spacing: 0) {
                            // Status bar color
                            Color(hex: "FFF8E1")
                                .frame(height: 0) // Takes up status bar space
                                .edgesIgnoringSafeArea(.top)
                            
                            // Custom header content
                            HStack(alignment: .center) {
                                Text("Posts")
                                    .font(.system(size: 34, weight: .bold))
                                    .foregroundColor(.black)
                                
                                Spacer()
                                
                                Button(action: {
                                    // Navigate to notification view
                                    showNotifications = true
                                }) {
                                    Image(systemName: "envelope")
                                        .font(.system(size: 24))
                                        .foregroundColor(.black)
                                        .frame(width: 44, height: 44)
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                            .background(Color(hex: "FFF8E1"))
                        }
                    }
                    .navigationBarHidden(true) // Hide the default navigation bar
                    .fullScreenCover(isPresented: $showNotifications) {
                        NotificationView(isPresented: $showNotifications)
                    }
                }
                .navigationViewStyle(StackNavigationViewStyle())
                
            case 3:
                StatisticsView()
                
            case 4:
                HomeView()
                
            default:
                PostsFeedView()
            }
        }
    }
}

struct MainAppView_Previews: PreviewProvider {
    static var previews: some View {
        MainAppView()
    }
}
