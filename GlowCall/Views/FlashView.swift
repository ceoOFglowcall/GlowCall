import SwiftUI
import UIKit

struct FlashView: View {
    @Environment(AppState.self) private var appState
    @State private var showHint = false
    @State private var showControls = false
    @State private var controlsTimer: Timer? = nil
    @State private var lastTapTime: Date = .distantPast
    @State private var timerCancellable: Timer? = nil
    @State private var previousBrightness: CGFloat = 0.5
    var s: GCStrings { appState.s }
    var flashColor: Color { appState.flashColor() }
    var brightnessValue: Double { appState.brightness / 100.0 }

    var body: some View {
        @Bindable var appState = appState

        ZStack {
            // Full screen color
            flashColor
                .ignoresSafeArea()
                .brightness(brightnessValue - 1.0)

            VStack(spacing: 0) {
                // Timer badge - top right
                HStack {
                    Spacer()
                    if appState.timerMinutes > 0 && appState.timerSecondsRemaining > 0 {
                        Text(timerText)
                            .font(.system(size: 13, weight: .semibold))
                            .monospacedDigit()
                            .foregroundColor(.black.opacity(0.45))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.black.opacity(0.15))
                            .clipShape(Capsule())
                            .transition(.opacity)
                    }
                }
                .padding(.top, 20)
                .padding(.trailing, 20)

                // Hint - below timer, centered
                if showHint {
                    Text(s.flashHint)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.black.opacity(0.5))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 7)
                        .background(Color.black.opacity(0.18))
                        .clipShape(Capsule())
                        .padding(.top, 10)
                        .transition(.opacity)
                }

                Spacer()
            }

            // Controls panel
            if showControls {
                VStack {
                    Spacer()
                    FlashControlPanel(onClose: closeFlash)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            handleTap()
        }
        .statusBarHidden(true)
        .onAppear {
            openFlash()
        }
        .onDisappear {
            closeCleanup()
        }
    }

    var timerText: String {
        let m = appState.timerSecondsRemaining / 60
        let s = appState.timerSecondsRemaining % 60
        return "\(m):\(String(format: "%02d", s))"
    }

    func openFlash() {
        let screen = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?.windows.first?.screen
        previousBrightness = screen?.brightness ?? 0.5
        screen?.brightness = appState.brightness / 100.0
        UIApplication.shared.isIdleTimerDisabled = true

        withAnimation { showHint = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation { showHint = false }
        }

        if appState.timerMinutes > 0 {
            appState.timerSecondsRemaining = appState.timerMinutes * 60
            timerCancellable = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                if appState.timerSecondsRemaining > 0 {
                    appState.timerSecondsRemaining -= 1
                } else {
                    closeFlash()
                }
            }
        }

        checkBattery()
    }

    func closeFlash() {
        withAnimation(.easeInOut(duration: 0.6)) {
            appState.isFlashActive = false
        }
    }

    func closeCleanup() {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?.windows.first?.screen.brightness = previousBrightness
        UIApplication.shared.isIdleTimerDisabled = false
        timerCancellable?.invalidate()
        controlsTimer?.invalidate()
        appState.timerSecondsRemaining = 0
    }

    func handleTap() {
        let now = Date()
        if now.timeIntervalSince(lastTapTime) < 0.32 {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            closeFlash()
            lastTapTime = .distantPast
        } else {
            lastTapTime = now
            toggleControls()
        }
    }

    func toggleControls() {
        controlsTimer?.invalidate()
        withAnimation(.easeInOut(duration: 0.25)) {
            showControls.toggle()
        }
        if showControls {
            controlsTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
                withAnimation(.easeInOut(duration: 0.25)) {
                    showControls = false
                }
            }
        }
    }

    func checkBattery() {
        UIDevice.current.isBatteryMonitoringEnabled = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            let level = UIDevice.current.batteryLevel
            let state = UIDevice.current.batteryState
            if level > 0 && level <= 0.2 && state != .charging && appState.brightness > 60 {
                appState.showBatterySheet = true
            }
        }
    }
}

#Preview {
    FlashView()
        .environment(AppState())
}
