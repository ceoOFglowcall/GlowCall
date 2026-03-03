import SwiftUI

struct OnboardingView: View {
    @Environment(AppState.self) private var appState
    @State private var showPipNote = false

    var s: GCStrings { appState.s }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {

                    HStack {
                        HStack(spacing: 0) {
                            Text("Glow")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Color(hex: "#f2f2f7"))
                            Text("Call")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Color(hex: "#f5c518"))
                        }
                        Spacer()
                        LanguagePill()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 14)
                    .padding(.bottom, 28)

                    Text(s.obHeading)
                        .font(.system(size: 28, weight: .bold))
                        .tracking(-0.5)
                        .foregroundColor(Color(hex: "#f2f2f7"))
                        .padding(.horizontal, 20)

                    Text(s.obSub)
                        .font(.system(size: 15))
                        .foregroundColor(Color(hex: "#636366"))
                        .lineSpacing(4)
                        .padding(.horizontal, 20)
                        .padding(.top, 6)
                        .padding(.bottom, 36)

                    VStack(spacing: 0) {
                        ObStep(icon: "☀️", title: s.ob1t, desc: s.ob1p)
                        Divider().background(Color.white.opacity(0.09))
                        ObStep(icon: "📱", title: s.ob2t, desc: s.ob2p)
                        Divider().background(Color.white.opacity(0.09))

                        VStack(alignment: .leading, spacing: 0) {
                            ObStep(icon: "💡", title: s.ob3t, desc: s.ob3p)

                            if showPipNote {
                                HStack(alignment: .top, spacing: 8) {
                                    Rectangle()
                                        .fill(Color(hex: "#f5c518").opacity(0.4))
                                        .frame(width: 2)
                                        .cornerRadius(1)
                                    VStack(alignment: .leading, spacing: 3) {
                                        Text(s.ob3note)
                                            .font(.system(size: 12, weight: .bold))
                                            .foregroundColor(Color(hex: "#f5c518"))
                                        Text(s.ob3pip)
                                            .font(.system(size: 12))
                                            .foregroundColor(Color(hex: "#636366"))
                                            .lineSpacing(3)
                                    }
                                }
                                .padding(10)
                                .background(Color.white.opacity(0.04))
                                .cornerRadius(8)
                                .padding(.horizontal, 20)
                                .padding(.bottom, 8)
                                .transition(.opacity.combined(with: .move(edge: .top)))
                            }

                            Button {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    showPipNote.toggle()
                                }
                            } label: {
                                HStack(spacing: 4) {
                                    Text(showPipNote ? s.ob3less : s.ob3more)
                                    Text(showPipNote ? "↑" : "↓")
                                }
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(Color(hex: "#f5c518"))
                            }
                            .padding(.horizontal, 20)
                            .padding(.bottom, 20)
                        }
                    }

                    Spacer(minLength: 32)

                    VStack(spacing: 12) {
                        

                        Button {
                            withAnimation {
                                appState.hasSeenOnboarding = true
                            }
                        } label: {
                            Text(s.obCta)
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 17)
                                .background(Color(hex: "#f5c518"))
                                .cornerRadius(14)
                                .shadow(color: Color(hex: "#f5c518").opacity(0.2), radius: 12, y: 4)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 36)
                }
            }
        }
    }
}

struct ObStep: View {
    let icon: String
    let title: String
    let desc: String

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Text(icon)
                .font(.system(size: 20))
                .frame(width: 42, height: 42)
                .background(Color(hex: "#1a1a1a"))
                .cornerRadius(12)

            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(Color(hex: "#f2f2f7"))
                Text(desc)
                    .font(.system(size: 13))
                    .foregroundColor(Color(hex: "#636366"))
                    .lineSpacing(3)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
    }
}

#Preview {
    OnboardingView()
        .environment(AppState())
}
