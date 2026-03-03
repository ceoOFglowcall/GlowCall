import SwiftUI

struct FlashControlPanel: View {
    @Environment(AppState.self) private var appState
    let onClose: () -> Void

    var body: some View {
        @Bindable var appState = appState

        VStack(spacing: 12) {

            // MARK: Color Swatches
            HStack(spacing: 10) {
                ForEach(PRESETS.indices, id: \.self) { i in
                    let preset = PRESETS[i]
                    let isLocked = !preset.isFree && !appState.isPro
                    let isSelected = appState.selectedPresetIndex == i

                    Button {
                        if isLocked {
                            appState.showPremiumSheet = true
                        } else {
                            appState.selectPreset(i)
                        }
                    } label: {
                        ZStack {
                            Circle()
                                .fill(preset.color)
                                .frame(width: 38, height: 38)
                                .overlay(
                                    Circle()
                                        .stroke(Color.black.opacity(0.3), lineWidth: isSelected ? 3 : 0)
                                )
                                .shadow(color: .black.opacity(0.2), radius: 4, y: 2)

                            if isLocked {
                                Text("🔒")
                                    .font(.system(size: 12))
                            }
                        }
                        .opacity(isLocked ? 0.4 : 1.0)
                    }
                    .buttonStyle(.plain)
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)

            // MARK: Brightness
            VStack(spacing: 4) {
                HStack {
                    Text(appState.s.brSliderLabel)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.black.opacity(0.55))
                    Spacer()
                    Text("\(Int(appState.brightness))%")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.black.opacity(0.55))
                        .monospacedDigit()
                }
                .padding(.horizontal, 2)

                HStack(spacing: 10) {
                    Text("☀")
                        .font(.system(size: 13))
                        .foregroundColor(.black.opacity(0.5))
                    Slider(value: $appState.brightness, in: 10...100, step: 1)
                        .tint(Color.black.opacity(0.5))
                        .onChange(of: appState.brightness) {
                            UIApplication.shared.connectedScenes
                                .compactMap { $0 as? UIWindowScene }
                                .first?.windows.first?.screen.brightness = appState.brightness / 100.0
                        }
                    Text("☀")
                        .font(.system(size: 18))
                        .foregroundColor(.black.opacity(0.7))
                }
            }

            // MARK: Warmth - more visible
            VStack(spacing: 4) {
                HStack {
                    Text(appState.s.wmLabel)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.black.opacity(0.55))
                    Spacer()
                    if !appState.isPro {
                        Text("🔒 Pro")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundColor(.black.opacity(0.4))
                    }
                }
                .padding(.horizontal, 2)

                HStack(spacing: 10) {
                    Text("❄")
                        .font(.system(size: 13))
                        .foregroundColor(.black.opacity(0.6))

                    Slider(value: $appState.warmth, in: 0...100, step: 1)
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
                        .opacity(appState.isPro ? 1.0 : 0.65)

                    Text("🔆")
                        .font(.system(size: 18))
                        .foregroundColor(.black.opacity(0.7))
                }
            }

            // MARK: Eye Protection Toggle
            HStack {
                HStack(spacing: 8) {
                    Text("👁")
                        .font(.system(size: 15))
                    Text(appState.s.eyeProtection)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.black.opacity(0.6))
                }
                Spacer()
                Toggle("", isOn: $appState.eyeMode)
                    .labelsHidden()
                    .tint(Color(hex: "#888888"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white.opacity(0.4), lineWidth: 1.5)
                    )
            }
            Text(appState.eyeMode ? "" : (appState.language == "tr" ? "Soğuk Beyaz için Göz Koruma Modu önerilir" : "Eye Protection Mode recommended for Cool White"))
                .font(.system(size: 11))
                .foregroundColor(.black.opacity(0.45))
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 16)
                .padding(.top, 4)

            // MARK: Close Button
            Button(action: onClose) {
                Text(appState.s.close)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.black.opacity(0.6))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(Color.black.opacity(0.12))
                    .cornerRadius(14)
            }
            .buttonStyle(.plain)
        }
        .padding(20)
        .padding(.bottom, 8)
        .background(
            LinearGradient(
                colors: [Color.clear, Color.black.opacity(0.1)],
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}

#Preview {
    ZStack {
        Color(hex: "#eef4ff").ignoresSafeArea()
        VStack {
            Spacer()
            FlashControlPanel(onClose: {})
                .environment(AppState())
        }
    }
}
