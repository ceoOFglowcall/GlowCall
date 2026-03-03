import SwiftUI

struct BatterySheet: View {
    @Environment(AppState.self) private var appState

    var s: GCStrings { appState.s }

    var body: some View {
        ZStack {
            Color.black.opacity(0.65)
                .ignoresSafeArea()
                .onTapGesture {
                    appState.showBatterySheet = false
                }

            VStack {
                Spacer()

                VStack(spacing: 0) {
                    // Handle
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.white.opacity(0.15))
                        .frame(width: 36, height: 4)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 16)

                    // Battery icon
                    Text("🔋")
                        .font(.system(size: 44))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 12)

                    // Title
                    Text(s.battTitle)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color(hex: "#f2f2f7"))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 6)

                    // Subtitle
                    Text(s.battSub)
                        .font(.system(size: 14))
                        .foregroundColor(Color(hex: "#636366"))
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .padding(.bottom, 20)

                    // Dim button
                    Button {
                        appState.brightness = 50
                        appState.showBatterySheet = false
                    } label: {
                        Text(s.battDim)
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 15)
                            .background(Color(hex: "#f5c518"))
                            .cornerRadius(13)
                    }
                    .buttonStyle(.plain)
                    .padding(.bottom, 8)

                    // Continue button
                    Button {
                        appState.showBatterySheet = false
                    } label: {
                        Text(s.battOk)
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(Color(hex: "#f2f2f7"))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 15)
                            .background(Color(hex: "#1a1a1a"))
                            .cornerRadius(13)
                    }
                    .buttonStyle(.plain)
                }
                .padding(20)
                .padding(.bottom, 8)
                .background(Color(hex: "#1c1c1e"))
                .cornerRadius(24, corners: [.topLeft, .topRight])
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Color.white.opacity(0.08), lineWidth: 1)
                        .mask(
                            VStack(spacing: 0) {
                                Rectangle().frame(height: 1)
                                Spacer()
                            }
                        )
                )
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    BatterySheet()
        .environment(AppState())
}
