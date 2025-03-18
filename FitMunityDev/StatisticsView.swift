//
//  StatisticsView.swift
//  FitMunityDev
//
//  Created by Haoran Jisun on 3/18/25.
//


import SwiftUI

struct StatisticsView: View {
    var body: some View {
        VStack(spacing: 20) {
            // Header title
            Text("Statistic")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top)
            
            // Goal progress banner
            HStack(spacing: 6) {
                // Checkmark in a dotted rectangle
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [4]))
                        .foregroundColor(.black)
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: "checkmark")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.black)
                }
                
                // Progress indicator with text
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color(hex: "FFDD66"))
                        .frame(height: 50)
                    
                    HStack {
                        // Circular progress
                        ZStack {
                            Circle()
                                .stroke(Color.white.opacity(0.5), lineWidth: 6)
                                .frame(width: 44, height: 44)
                            
                            Circle()
                                .trim(from: 0, to: 0.65)
                                .stroke(Color.white, lineWidth: 6)
                                .frame(width: 44, height: 44)
                                .rotationEffect(.degrees(-90))
                            
                            Text("65%")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.white)
                        }
                        
                        // Text content
                        VStack(alignment: .leading, spacing: 0) {
                            Text("You're going to reach your goal by")
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                            
                            Text("3 Aug 2022")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 12)
                }
            }
            .padding(.horizontal)
            
            // Calorie information card
            VStack(spacing: 16) {
                // Calorie number
                Text("1194 kcal")
                    .font(.system(size: 32, weight: .bold))
                
                // Date and activities
                HStack(spacing: 16) {
                    Text("March 28")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                    
                    HStack(spacing: 4) {
                        Text("2")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.black)
                        
                        Text("Activities")
                            .font(.system(size: 16))
                            .foregroundColor(Color.black.opacity(0.6))
                    }
                }
                
                // Graph
                CalorieGraphView()
                    .frame(height: 150)
                
                // Legend
                HStack(spacing: 20) {
                    HStack(spacing: 8) {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 8, height: 8)
                        
                        Text("Gained")
                            .font(.system(size: 14))
                    }
                    
                    HStack(spacing: 8) {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 8, height: 8)
                        
                        Text("Burnt")
                            .font(.system(size: 14))
                    }
                }
            }
            .padding(20)
            .background(Color(hex: "FFF4D0"))
            .cornerRadius(20)
            .padding(.horizontal)
            
            // Statistics summary
            HStack(spacing: 0) {
                // Calories gained
                VStack(alignment: .leading, spacing: 4) {
                    HStack(alignment: .lastTextBaseline, spacing: 2) {
                        Text("1739")
                            .font(.system(size: 28, weight: .bold))
                        
                        Text("kcal")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    
                    Text("Calory gained")
                        .font(.system(size: 14))
                    
                    Text("59%")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.green)
                    
                    Rectangle()
                        .fill(Color.green)
                        .frame(height: 3)
                        .frame(maxWidth: .infinity)
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // Calories burnt
                VStack(alignment: .leading, spacing: 4) {
                    HStack(alignment: .lastTextBaseline, spacing: 2) {
                        Text("-545")
                            .font(.system(size: 28, weight: .bold))
                        
                        Text("kcal")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    
                    Text("Calory burnt")
                        .font(.system(size: 14))
                    
                    Text("32%")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.red)
                    
                    Rectangle()
                        .fill(Color.red)
                        .frame(height: 3)
                        .frame(maxWidth: .infinity)
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .padding(.horizontal)
            
            Spacer()
        }
        .background(Color(hex: "FFF8E1"))
    }
}

struct CalorieGraphView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Grid lines
                VStack(spacing: 0) {
                    ForEach(0..<5) { _ in
                        Divider()
                            .background(Color.gray.opacity(0.3))
                        Spacer()
                    }
                    Divider()
                        .background(Color.gray.opacity(0.3))
                }
                
                // Green graph (gained calories)
                Path { path in
                    let width = geometry.size.width
                    let height = geometry.size.height
                    
                    // Starting point
                    path.move(to: CGPoint(x: 0, y: height * 0.8))
                    
                    // Control points for curve
                    path.addCurve(
                        to: CGPoint(x: width, y: height * 0.4),
                        control1: CGPoint(x: width * 0.4, y: height * 0.6),
                        control2: CGPoint(x: width * 0.7, y: height * 0.7)
                    )
                    
                    // Complete the path for filling
                    path.addLine(to: CGPoint(x: width, y: height))
                    path.addLine(to: CGPoint(x: 0, y: height))
                    path.closeSubpath()
                }
                .fill(Color.green.opacity(0.2))
                
                // Green line
                Path { path in
                    let width = geometry.size.width
                    let height = geometry.size.height
                    
                    path.move(to: CGPoint(x: 0, y: height * 0.8))
                    path.addCurve(
                        to: CGPoint(x: width, y: height * 0.4),
                        control1: CGPoint(x: width * 0.4, y: height * 0.6),
                        control2: CGPoint(x: width * 0.7, y: height * 0.7)
                    )
                }
                .stroke(Color.green, lineWidth: 2)
                
                // Green endpoint indicator
                Circle()
                    .fill(Color.green)
                    .frame(width: 8, height: 8)
                    .position(x: geometry.size.width, y: geometry.size.height * 0.4)
                
                // Red graph (burnt calories)
                Path { path in
                    let width = geometry.size.width
                    let height = geometry.size.height
                    
                    // Starting point
                    path.move(to: CGPoint(x: 0, y: height * 0.9))
                    
                    // Control points for curve
                    path.addCurve(
                        to: CGPoint(x: width, y: height * 0.7),
                        control1: CGPoint(x: width * 0.4, y: height * 0.85),
                        control2: CGPoint(x: width * 0.7, y: height * 0.8)
                    )
                    
                    // Complete the path for filling
                    path.addLine(to: CGPoint(x: width, y: height))
                    path.addLine(to: CGPoint(x: 0, y: height))
                    path.closeSubpath()
                }
                .fill(Color.red.opacity(0.2))
                
                // Red line
                Path { path in
                    let width = geometry.size.width
                    let height = geometry.size.height
                    
                    path.move(to: CGPoint(x: 0, y: height * 0.9))
                    path.addCurve(
                        to: CGPoint(x: width, y: height * 0.7),
                        control1: CGPoint(x: width * 0.4, y: height * 0.85),
                        control2: CGPoint(x: width * 0.7, y: height * 0.8)
                    )
                }
                .stroke(Color.red, lineWidth: 2)
                
                // Red endpoint indicator
                Circle()
                    .fill(Color.red)
                    .frame(width: 8, height: 8)
                    .position(x: geometry.size.width, y: geometry.size.height * 0.7)
                
                // Starting points indicators
                Circle()
                    .fill(Color.green)
                    .frame(width: 8, height: 8)
                    .position(x: 0, y: geometry.size.height * 0.8)
                
                Circle()
                    .fill(Color.red)
                    .frame(width: 8, height: 8)
                    .position(x: 0, y: geometry.size.height * 0.9)
            }
        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
}
