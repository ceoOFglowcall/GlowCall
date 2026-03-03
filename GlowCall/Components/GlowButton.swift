import SwiftUI

struct GlowButton: View {
    let title: String
    let action: () -> Void

    @State private var glowScale: CGFloat = 1.0

    var body: some View {
        Button(action: {
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            action()
        }) {
            HStack(spacing: 10) {
                // Pulsing dot
                Circle()
                    .fill(Color(hex: "#f5c518"))
                    .frame(width: 10, height: 10)
                    .shadow(color: Color(hex: "#f5c518").opacity(glowScale == 1.0 ? 0.4 : 0.75),
                            radius: glowScale == 1.0 ? 5 : 9)
                    .scaleEffect(glowScale)

                Text(title)
                    .font(.system(size: 18, weight: .bold))
                    .tracking(-0.3)
                    .foregroundColor(Color(hex: "#f2f2f7"))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(
                ZStack {
                    Color(hex: "#0f0f0f")
                    RadialGradient(
                        gradient: Gradient(colors: [
                            Color(hex: "#f5c518").opacity(0.07),
                            Color.clear
                        ]),
                        center: .init(x: 0.3, y: 0.5),
                        startRadius: 0,
                        endRadius: 120
                    )
                }
            )
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
        .onAppear {
            withAnimation(
                .easeInOut(duration: 2)
                .repeatForever(autoreverses: true)
            ) {
                glowScale = 1.15
            }
        }
    }
}

#Preview {
    GlowButton(title: "Işığı Aç") {}
        .padding()
        .background(Color.black)
}
