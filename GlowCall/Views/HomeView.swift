import SwiftUI

struct HomeView: View {
    @Environment(AppState.self) private var appState
    @State private var timerSelection: Int = 0

    var s: GCStrings { appState.s }

    var body: some View {
        @Bindable var appState = appState

        ZStack {
            Color.black.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {

                    // MARK: Nav
                    HStack {
                        HStack(spacing: 0) {
                            Text("Glow")
                                .font(.system(size: 22, weight: .bold))
                                .tracking(-0.5)
                                .foregroundColor(Color(hex: "#f2f2f7"))
                            Text("Call")
                                .font(.system(size: 22, weight: .bold))
                                .tracking(-0.5)
                                .foregroundColor(Color(hex: "#f5c518"))
                        }
                        Spacer()
                        LanguagePill()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 14)
                    .padding(.bottom, 20)

                    // MARK: Presets
                    SectionHeader(title: s.presetTitle)
                    PresetGrid()
                        .padding(.horizontal, 20)
                        .padding(.bottom, 22)

                    // MARK: Brightness
                    SectionHeader(title: s.brTitle)
                    CardView {
                        VStack(spacing: 10) {
                            HStack {
                                Text(s.brLabel)
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(Color(hex: "#f2f2f7"))
                                Spacer()
                                Text("\(Int(appState.brightness))%")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(Color(hex: "#f5c518"))
                                    .monospacedDigit()
                            }
                            BrightnessSlider(value: $appState.brightness)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)

                    // MARK: Warmth
                    SectionHeader(title: s.wmTitle)
                    CardView {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text(s.wmLabel)
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(Color(hex: "#f2f2f7"))
                                Spacer()
                                Text(appState.warmthLabel())
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(Color(hex: "#f5c518"))
                            }
                            Text(s.wmLocked)
                                .font(.system(size: 12))
                                .foregroundColor(Color(hex: "#636366"))
                            WarmthSlider(value: $appState.warmth)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)

                    // MARK: Timer
                    SectionHeader(title: s.timerTitle)
                    CardView {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(s.timerLabel)
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(Color(hex: "#f2f2f7"))
                            TimerSelector(selected: $appState.timerMinutes)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 22)

                    // MARK: Activate Button
                    GlowButton(title: s.activate) {
                        withAnimation {
                            appState.isFlashActive = true
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 16)

                    // MARK: Footer
                    HStack(spacing: 24) {
                        Button {
                            withAnimation {
                                appState.hasSeenOnboarding = false
                            }
                        } label: {
                            Text(s.howTo)
                                .font(.system(size: 13))
                                .foregroundColor(Color(hex: "#636366"))
                        }

                        Button {
                            appState.showPremiumSheet = true
                        } label: {
                            Text(s.pro)
                                .font(.system(size: 13))
                                .foregroundColor(Color(hex: "#636366"))
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 36)
                }
            }
        }
    }
}

// MARK: - Section Header
struct SectionHeader: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.system(size: 12, weight: .semibold))
            .foregroundColor(Color(hex: "#636366"))
            .tracking(0.04 * 12)
            .textCase(.uppercase)
            .padding(.horizontal, 20)
            .padding(.bottom, 10)
    }
}

// MARK: - Card
struct CardView<Content: View>: View {
    let content: Content
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    var body: some View {
        content
            .padding(16)
            .background(Color(hex: "#0f0f0f"))
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white.opacity(0.09), lineWidth: 1)
            )
    }
}

#Preview {
    HomeView()
        .environment(AppState())
}
