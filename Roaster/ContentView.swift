import SwiftUI

struct ContentView: View {
    @State private var selectedRoast: Roast?
    @State private var showingRandomRoast = false
    @State private var selectedCategory: Roast.Category?
    @State private var animateGradient = false

    private var filteredRoasts: [Roast] {
        if let category = selectedCategory {
            return Roast.allRoasts.filter { $0.category == category }
        }
        return Roast.allRoasts
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()

                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.black,
                        Color.red.opacity(0.15),
                        Color.orange.opacity(0.1),
                        Color.black
                    ]),
                    startPoint: animateGradient ? .topLeading : .bottomTrailing,
                    endPoint: animateGradient ? .bottomTrailing : .topLeading
                )
                .ignoresSafeArea()
                .onAppear {
                    withAnimation(.easeInOut(duration: 5.0).repeatForever(autoreverses: true)) {
                        animateGradient.toggle()
                    }
                }

                ScrollView {
                    VStack(spacing: 20) {
                        // Header
                        VStack(spacing: 8) {
                            HStack {
                                Image(systemName: "flame.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(.red)
                                    .shadow(color: .red.opacity(0.5), radius: 10)

                                Text("ROASTER")
                                    .font(.system(size: 42, weight: .black, design: .rounded))
                                    .foregroundColor(.white)
                            }

                            Text("15 Savage Burns")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.top, 20)

                        // Random Roast Button
                        Button(action: {
                            selectedRoast = Roast.allRoasts.randomElement()
                            showingRandomRoast = true
                        }) {
                            HStack {
                                Image(systemName: "dice.fill")
                                    .font(.title3)
                                Text("Random Roast")
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [.red, .orange]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(16)
                            .shadow(color: .red.opacity(0.4), radius: 10, x: 0, y: 5)
                        }
                        .padding(.horizontal)

                        // Category Filter
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                CategoryButton(title: "All", isSelected: selectedCategory == nil) {
                                    selectedCategory = nil
                                }

                                ForEach(Roast.Category.allCases, id: \.self) { category in
                                    CategoryButton(title: category.rawValue, isSelected: selectedCategory == category) {
                                        selectedCategory = category
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }

                        // Roast Count
                        HStack {
                            Text("\(filteredRoasts.count) roasts")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        .padding(.horizontal)

                        // Roasts List
                        LazyVStack(spacing: 16) {
                            ForEach(filteredRoasts) { roast in
                                RoastCardView(roast: roast)
                                    .padding(.horizontal)
                            }
                        }
                        .padding(.bottom, 20)
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $showingRandomRoast) {
            if let roast = selectedRoast {
                RandomRoastView(roast: roast, isPresented: $showingRandomRoast)
            }
        }
    }
}

struct CategoryButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(isSelected ? Color.red : Color.white.opacity(0.1))
                .foregroundColor(isSelected ? .white : .gray)
                .cornerRadius(20)
        }
    }
}

struct RandomRoastView: View {
    let roast: Roast
    @Binding var isPresented: Bool

    private var categoryColor: Color {
        switch roast.category {
        case .savage: return Color.red
        case .witty: return Color.blue
        case .brutal: return Color.orange
        case .savageSays: return Color.purple
        case .classic: return Color.green
        }
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            LinearGradient(
                gradient: Gradient(colors: [
                    categoryColor.opacity(0.3),
                    Color.black
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 30) {
                Spacer()

                Image(systemName: "flame.fill")
                    .font(.system(size: 60))
                    .foregroundColor(categoryColor)
                    .shadow(color: categoryColor.opacity(0.5), radius: 20)

                Text(roast.text)
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineSpacing(6)
                    .padding(.horizontal, 30)

                Text(roast.category.rawValue)
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(categoryColor.opacity(0.3))
                    .foregroundColor(categoryColor)
                    .cornerRadius(12)

                Spacer()

                VStack(spacing: 12) {
                    Button(action: {
                        isPresented = false
                    }) {
                        Text("Done")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(16)
                    }
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 40)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
