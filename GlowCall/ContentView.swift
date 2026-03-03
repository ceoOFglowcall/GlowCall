import SwiftUI

struct ContentView: View {
    @State private var appState = AppState()

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            if appState.isFlashActive {
                FlashView()
                    .transition(.opacity)
            } else if !appState.hasSeenOnboarding {
                OnboardingView()
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
            } else {
                HomeView()
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
            }

            // Toast
            if let msg = appState.toastMessage {
                VStack {
                    Spacer()
                    ToastView(message: msg)
                        .padding(.bottom, 90)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }

            // Premium Sheet
            if appState.showPremiumSheet {
                PremiumSheet()
                    .transition(.opacity)
            }

            // Battery Sheet
            if appState.showBatterySheet {
                BatterySheet()
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.35), value: appState.hasSeenOnboarding)
        .animation(.easeInOut(duration: 0.35), value: appState.isFlashActive)
        .animation(.easeInOut(duration: 0.3),  value: appState.toastMessage)
        .animation(.easeInOut(duration: 0.3),  value: appState.showPremiumSheet)
        .animation(.easeInOut(duration: 0.3),  value: appState.showBatterySheet)
        .environment(appState)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
