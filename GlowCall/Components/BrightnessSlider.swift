import SwiftUI

struct BrightnessSlider: View {
    @Binding var value: Double

    var body: some View {
        Slider(value: $value, in: 10...100, step: 1)
            .tint(Color.white)
    }
}

struct WarmthSlider: View {
    @Binding var value: Double
    @Environment(AppState.self) private var appState

    var body: some View {
        HStack(spacing: 10) {
            Text("❄")
                .font(.system(size: 13))
                .opacity(0.4)

            Slider(value: $value, in: 0...100, step: 1)
                .tint(
                    LinearGradient(
                        colors: [
                            Color(hex: "#b8d8ff"),
                            Color(hex: "#fff8e0"),
                            Color(hex: "#ffc040"),
                            Color(hex: "#ff8800")
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in
                            if !appState.isPro {
                                appState.showPremiumSheet = true
                            }
                        }
                )
                .disabled(!appState.isPro)
                .opacity(appState.isPro ? 1.0 : 0.5)

            Text("🔆")
                .font(.system(size: 18))
                .opacity(0.6)
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        BrightnessSlider(value: .constant(75))
        WarmthSlider(value: .constant(50))
            .environment(AppState())
    }
    .padding()
    .background(Color.black)
}
