import SwiftUI

struct PremiumSheet: View {
    @Environment(AppState.self) private var appState

    var s: GCStrings { appState.s }

    var body: some View {
        ZStack {
            // Overlay
            Color.black.opacity(0.65)
                .ignoresSafeArea()
                .onTapGesture {
                    appState.showPremiumSheet = false
                }

            VStack {
                Spacer()

                VStack(alignment: .leading, spacing: 0) {

                    // Handle
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.white.opacity(0.15))
                        .frame(width: 36, height: 4)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 20)

                    // Close button
                    .overlay(alignment: .topTrailing) {
                        Button {
                            appState.showPremiumSheet = false
                        } label: {
                            Text("✕")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(Color(hex: "#636366"))
                                .frame(width: 28, height: 28)
                                .background(Color(hex: "#242424"))
                                .clipShape(Circle())
                        }
                        .offset(x: 0, y: -8)
                    }

                    // Pro badge
                    HStack(spacing: 5) {
                        Text("✦ GlowCall Pro")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(
                        LinearGradient(
                            colors: [Color(hex: "#f5c518"), Color(hex: "#ff9500")],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(20)
                    .padding(.bottom, 12)

                    // Title
                    Text(s.shTitle)
                        .font(.system(size: 24, weight: .bold))
                        .tracking(-0.5)
                        .foregroundColor(Color(hex: "#f2f2f7"))
                        .padding(.bottom, 6)

                    // Subtitle
                    Text(s.shSub)
                        .font(.system(size: 14))
                        .foregroundColor(Color(hex: "#636366"))
                        .lineSpacing(4)
                        .padding(.bottom, 22)

                    // Plans
                    HStack(spacing: 10) {
                        // Monthly
                        PlanCard(
                            period: s.shMonthly,
                            price: "₺50",
                            unit: s.shMo,
                            trial: s.shTrial,
                            isBest: false
                        )

                        // Yearly
                        PlanCard(
                            period: s.shYearly,
                            price: "₺500",
                            unit: s.shYr,
                            trial: s.shTrial,
                            isBest: true,
                            bestLabel: s.shBest
                        )
                    }
                    .padding(.bottom, 16)

                    // CTA
                    Button {
                        appState.showPremiumSheet = false
                        appState.showToast(s.comingSoon)
                    } label: {
                        Text(s.shCta)
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 17)
                            .background(
                                LinearGradient(
                                    colors: [Color(hex: "#f5c518"), Color(hex: "#ff9500")],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(14)
                            .shadow(color: Color(hex: "#f5c518").opacity(0.25), radius: 10, y: 4)
                    }
                    .buttonStyle(.plain)
                    .padding(.bottom, 10)

                    // Restore
                    Button {
                        appState.showPremiumSheet = false
                        appState.showToast(s.comingSoon)
                    } label: {
                        Text(s.shRestore)
                            .font(.system(size: 13))
                            .foregroundColor(Color(hex: "#636366"))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 6)
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

// MARK: - Plan Card
struct PlanCard: View {
    let period: String
    let price: String
    let unit: String
    let trial: String
    let isBest: Bool
    var bestLabel: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(period)
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(Color(hex: "#636366"))

            HStack(alignment: .lastTextBaseline, spacing: 2) {
                Text(price)
                    .font(.system(size: 22, weight: .regular))
                    .tracking(-0.5)
                    .foregroundColor(Color(hex: "#f2f2f7"))
                Text(unit)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(Color(hex: "#636366"))
            }

            Text(trial)
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(Color(hex: "#34c759"))
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(hex: "#1a1a1a"))
        .cornerRadius(14)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(
                    isBest ? Color(hex: "#f5c518").opacity(0.45) : Color.white.opacity(0.09),
                    lineWidth: 1.5
                )
        )
        .overlay(alignment: .top) {
            if isBest {
                Text(bestLabel)
                    .font(.system(size: 9, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 3)
                    .background(Color(hex: "#f5c518"))
                    .cornerRadius(10)
                    .offset(y: -10)
            }
        }
    }
}

// MARK: - Corner Radius Helper
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    PremiumSheet()
        .environment(AppState())
}
