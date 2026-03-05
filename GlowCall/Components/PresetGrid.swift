import SwiftUI

struct PresetGrid: View {
    @Environment(AppState.self) private var appState

    let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 4)

    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(PRESETS.indices, id: \.self) { i in
                PresetCard(index: i)
            }
        }
    }
}

struct PresetCard: View {
    @Environment(AppState.self) private var appState
    let index: Int

    var preset: ColorPreset { PRESETS[index] }
    var isSelected: Bool { appState.selectedPresetIndex == index }
    var isLocked: Bool { !preset.isFree && !appState.isPro }

    var body: some View {
        Button {
            if isLocked {
                appState.showPremiumSheet = true
            } else {
                withAnimation(.easeInOut(duration: 0.15)) {
                    appState.selectPreset(index)
                }
                let generator = UIImpactFeedbackGenerator(style: .light)
                generator.impactOccurred()
            }
        } label: {
            ZStack {
                // Background color
                RoundedRectangle(cornerRadius: 16)
                    .fill(preset.color)
                    .aspectRatio(1, contentMode: .fit)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(
                                isSelected ? Color(hex: "#f5c518") : Color.clear,
                                lineWidth: 2
                            )
                    )

                // Preset name - centered
                VStack(spacing: 0) {
                    Spacer()
                    Text(preset.name(lang: appState.language))
                        .font(.system(size: 10, weight: .semibold))
                        .tracking(-0.1)
                        .foregroundColor(.black.opacity(0.7))
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 4)
                        .padding(.bottom, 8)
                }

                // Free badge - top left (only when not selected)
                if preset.isFree && !isSelected {
                    VStack {
                        HStack {
                            Text(appState.s.freeBadge)
                                .font(.system(size: 8, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Color(hex: "#34c759").opacity(0.9))
                                .cornerRadius(6)
                                .padding(6)
                            Spacer()
                        }
                        Spacer()
                    }
                }

                // Lock icon - top right
                if isLocked {
                    VStack {
                        HStack {
                            Spacer()
                            Text("🔒")
                                .font(.system(size: 12))
                                .padding(7)
                        }
                        Spacer()
                    }
                }

                // Selected checkmark - top RIGHT corner
                if isSelected {
                    VStack {
                        HStack {
                            Spacer()
                            Circle()
                                .fill(Color(hex: "#f5c518"))
                                .frame(width: 18, height: 18)
                                .overlay(
                                    Text("✓")
                                        .font(.system(size: 10, weight: .bold))
                                        .foregroundColor(.black)
                                )
                                .padding(6)
                        }
                        Spacer()
                    }
                }
            }
        }
        .buttonStyle(.plain)
        .animation(.spring(response: 0.2), value: isSelected)
    }
}

#Preview {
    PresetGrid()
        .environment(AppState())
        .padding()
        .background(Color.black)
}
