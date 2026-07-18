import SwiftUI

struct RoastCardView: View {
    let roast: Roast
    @State private var isPressed = false

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
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(roast.category.rawValue)
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(categoryColor.opacity(0.2))
                    .foregroundColor(categoryColor)
                    .cornerRadius(8)

                Spacer()

                Image(systemName: "flame.fill")
                    .foregroundColor(categoryColor)
                    .font(.title3)
            }

            Text(roast.text)
                .font(.body)
                .foregroundColor(.white)
                .lineSpacing(4)
                .multilineTextAlignment(.leading)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            categoryColor.opacity(0.3),
                            categoryColor.opacity(0.1)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(categoryColor.opacity(0.4), lineWidth: 1)
                )
        )
        .shadow(color: categoryColor.opacity(0.3), radius: 10, x: 0, y: 5)
        .scaleEffect(isPressed ? 0.98 : 1.0)
        .onTapGesture {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isPressed = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    isPressed = false
                }
            }
        }
    }
}

struct RoastCardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            RoastCardView(roast: Roast.allRoasts[0])
                .padding()
        }
    }
}
