import SwiftUI

struct HomeView: View {
    @State private var selectedDate = Date()
    @State private var waterCount = 2 // Number of water glasses filled
    @State private var showDatePicker = false
    
    // Formatted date string
    private var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd yyyy"
        return formatter.string(from: selectedDate)
    }
    
    var body: some View {
        ZStack {
            // Background
            Color(hex: "FFF8E1")
                .ignoresSafeArea()
            
            // Main content
            ScrollView {
                VStack(spacing: 24) {
                    // Date header
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            showDatePicker = true
                        }) {
                            Text(dateString + " ▼")
                                .font(.headline)
                                .foregroundColor(Color(red: 0.09, green: 0.20, blue: 0.19))
                        }
                        
                        Spacer()
                        
                        Button(action: {}) {
                            ZStack {
                                Circle()
                                    .fill(Color(hex: "FFDD66"))
                                    .frame(width: 44, height: 44)
                                
                                Image(systemName: "calendar")
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    
                    // Greeting text
                    VStack(spacing: 4) {
                        Text("Good Morning ")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(Color(red: 0.09, green: 0.20, blue: 0.19))
                        + Text("☀️")
                            .font(.system(size: 32))
                        
                        HStack(spacing: 0) {
                            Text("You've gained ")
                                .foregroundColor(Color(red: 0.38, green: 0.49, blue: 0.48))
                            Text("2kg")
                                .foregroundColor(.green)
                            Text(" yesterday keep it up!")
                                .foregroundColor(Color(red: 0.38, green: 0.49, blue: 0.48))
                        }
                        .font(.system(size: 16))
                    }
                    
                    // Calorie card
                    CalorieCard()
                    
                    // Nutrition info
                    NutritionInfoView()
                    
                    // Water section
                    WaterTrackerView(waterCount: $waterCount)
                    
                    // Add padding at the bottom to ensure content is visible above tab bar
                    Spacer()
                        .frame(height: 80)
                }
            }
            
            // Date picker popup overlay
            if showDatePicker {
                DatePickerOverlay(isShowing: $showDatePicker, selectedDate: $selectedDate)
            }
        }
    }
}

// Separate components for better organization and reusability

struct CalorieCard: View {
    var body: some View {
        VStack(spacing: 8) {
            Text("Calories")
                .font(.headline)
                .foregroundColor(Color(red: 0.18, green: 0.19, blue: 0.23))
                .frame(maxWidth: .infinity, alignment: .center)
            
            Text("1739")
                .font(.system(size: 70, weight: .bold))
                .foregroundColor(Color(red: 0.18, green: 0.19, blue: 0.23))
            + Text(" kcal")
                .font(.system(size: 16))
                .foregroundColor(Color(red: 0.85, green: 0.85, blue: 0.85))
            
            Text("of 2925 kcal")
                .font(.system(size: 14))
                .foregroundColor(Color(red: 0.85, green: 0.85, blue: 0.85))
            
            // Circular progress
            ZStack {
                // Background arc
                Circle()
                    .trim(from: 0, to: 0.75)
                    .stroke(
                        Color(red: 0.62, green: 0.82, blue: 0.19).opacity(0.3),
                        style: StrokeStyle(lineWidth: 20, lineCap: .round)
                    )
                    .frame(width: 200, height: 200)
                    .rotationEffect(.degrees(135))
                
                // Progress arc
                Circle()
                    .trim(from: 0, to: 0.75 * 0.6) // 60% of the full arc
                    .stroke(
                        Color(red: 0.20, green: 0.66, blue: 0.31),
                        style: StrokeStyle(lineWidth: 20, lineCap: .round)
                    )
                    .frame(width: 200, height: 200)
                    .rotationEffect(.degrees(135))
                
                // Center flame icon
                Image(systemName: "flame.fill")
                    .font(.system(size: 28))
                    .foregroundColor(Color(red: 0.20, green: 0.66, blue: 0.31))
            }
            .padding(.vertical, 10)
        }
        .padding(20)
        .background(Color(red: 1, green: 0.93, blue: 0.75).opacity(0.5))
        .cornerRadius(25)
        .padding(.horizontal, 20)
    }
}

struct NutritionInfoView: View {
    var body: some View {
        HStack(spacing: 40) {
            // Carbs
            VStack(alignment: .leading, spacing: 4) {
                Text("134")
                    .font(.system(size: 32, weight: .bold))
                + Text("g")
                    .font(.system(size: 14))
                    .foregroundColor(Color(red: 0.85, green: 0.85, blue: 0.85))
                
                Text("Total carbs")
                    .font(.system(size: 16, weight: .bold))
                
                Text("28%")
                    .font(.system(size: 14))
                    .foregroundColor(Color(red: 0.85, green: 0.85, blue: 0.85))
                
                // Progress bar
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(Color.pink.opacity(0.3))
                            .frame(height: 5)
                        
                        Rectangle()
                            .fill(Color.pink)
                            .frame(width: geometry.size.width * 0.28, height: 5)
                    }
                }
                .frame(height: 5)
            }
            
            // Fat
            VStack(alignment: .leading, spacing: 4) {
                Text("94")
                    .font(.system(size: 32, weight: .bold))
                + Text("g")
                    .font(.system(size: 14))
                    .foregroundColor(Color(red: 0.85, green: 0.85, blue: 0.85))
                
                Text("Total fat")
                    .font(.system(size: 16, weight: .bold))
                
                Text("81%")
                    .font(.system(size: 14))
                    .foregroundColor(Color(red: 0.85, green: 0.85, blue: 0.85))
                
                // Progress bar
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(Color(hex: "FFDD66").opacity(0.3))
                            .frame(height: 5)
                        
                        Rectangle()
                            .fill(Color(hex: "FFDD66"))
                            .frame(width: geometry.size.width * 0.81, height: 5)
                    }
                }
                .frame(height: 5)
            }
        }
        .padding(.horizontal, 25)
    }
}

struct WaterTrackerView: View {
    @Binding var waterCount: Int
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Water")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(Color(red: 0.09, green: 0.20, blue: 0.19))
                
                Spacer()
                
                Button(action: {}) {
                    ZStack {
                        Circle()
                            .fill(Color(red: 0.09, green: 0.20, blue: 0.19))
                            .frame(width: 40, height: 40)
                        
                        Image(systemName: "ellipsis")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .rotationEffect(.degrees(90))
                    }
                }
            }
            .padding(.horizontal, 20)
            
            // Water tracker
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color(hex: "FFDD66"))
                    .frame(height: 120)
                
                VStack(spacing: 24) {
                    // Progress text
                    HStack {
                        Text("570/2000ml")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Text("20%")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 20)
                    
                    // Cup icons
                    HStack(spacing: 15) {
                        ForEach(0..<7) { index in
                            Button(action: {
                                // Update water count
                                if index < waterCount {
                                    waterCount = index
                                } else {
                                    waterCount = index + 1
                                }
                            }) {
                                Image(systemName: index < waterCount ? "cup.and.saucer.fill" : "cup.and.saucer")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
                .padding(.top, 8)
            }
            .padding(.horizontal, 20)
        }
    }
}

struct DatePickerOverlay: View {
    @Binding var isShowing: Bool
    @Binding var selectedDate: Date
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    isShowing = false
                }
            
            VStack(spacing: 0) {
                // Month picker
                VStack(spacing: 0) {
                    ForEach(["January", "February", "March", "April", "May"], id: \.self) { month in
                        HStack {
                            Text(month)
                                .font(.system(size: 18))
                                .foregroundColor(.black.opacity(0.8))
                                .frame(width: 120, alignment: .leading)
                            
                            Spacer()
                            
                            Text(month == "March" ? "28" :
                                 month == "January" ? "26" :
                                 month == "February" ? "27" :
                                 month == "April" ? "29" : "30")
                                .font(.system(size: 18))
                                .foregroundColor(.black.opacity(0.8))
                                .frame(width: 60, alignment: .center)
                            
                            Text(month == "March" ? "2022" :
                                 month == "January" ? "2020" :
                                 month == "February" ? "2021" :
                                 month == "April" ? "2023" : "2024")
                                .font(.system(size: 18))
                                .foregroundColor(.black.opacity(0.8))
                                .frame(width: 60, alignment: .center)
                        }
                        .padding(.vertical, 12)
                        .background(month == "March" ? Color.green.opacity(0.2) : Color.clear)
                        .cornerRadius(20)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                
                Divider()
                    .padding(.horizontal, 20)
                
                // Selection button
                HStack {
                    Text("Select")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Image(systemName: "checkmark")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.green)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
            }
            .background(Color.white)
            .cornerRadius(20)
            .padding(.horizontal, 40)
            
            // Cancel button
            VStack {
                Spacer()
                
                Button(action: {
                    isShowing = false
                }) {
                    HStack {
                        Text("Cancel")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.red)
                        
                        Spacer()
                        
                        Image(systemName: "xmark")
                            .font(.system(size: 18))
                            .foregroundColor(.red)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.horizontal, 40)
                    .padding(.bottom, 100)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
