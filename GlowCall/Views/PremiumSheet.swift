import SwiftUI
import StoreKit

struct PremiumSheet: View {
    private enum PlanSelection {
        case monthly
        case yearly
    }

    private let monthlyProductID = "glowcall.pro.monthly"
    private let yearlyProductID = "glowcall.pro.yearly"
    private let termsURL = URL(string: "https://github.com/ceoOFglowcall/GlowCall/blob/glowcall-update-1/TERMS_OF_USE.md")
    private let privacyURL = URL(string: "https://github.com/ceoOFglowcall/GlowCall/blob/glowcall-update-1/PRIVACY_POLICY.md")

    @Environment(AppState.self) private var appState
    @Environment(\.openURL) private var openURL
    @State private var monthlyProduct: Product?
    @State private var yearlyProduct: Product?
    @State private var selectedPlan: PlanSelection = .yearly
    @State private var isLoadingProducts = false
    @State private var isPurchasing = false

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
                        .padding(.bottom, 14)

                    VStack(alignment: .leading, spacing: 8) {
                        FeatureRow(text: s.proFeature1)
                        FeatureRow(text: s.proFeature2)
                        FeatureRow(text: s.proFeature3)
                    }
                    .padding(.bottom, 18)

                    // Plans
                    HStack(spacing: 10) {
                        // Monthly
                        PlanCard(
                            period: s.shMonthly,
                            price: monthlyProduct?.displayPrice ?? "—",
                            unit: s.shMo,
                            trial: s.shTrial,
                            isBest: false,
                            isSelected: selectedPlan == .monthly
                        )
                        .onTapGesture { selectedPlan = .monthly }

                        // Yearly
                        PlanCard(
                            period: s.shYearly,
                            price: yearlyProduct?.displayPrice ?? "—",
                            unit: s.shYr,
                            trial: s.shTrial,
                            isBest: true,
                            bestLabel: s.shBest,
                            isSelected: selectedPlan == .yearly
                        )
                        .onTapGesture { selectedPlan = .yearly }
                    }
                    .padding(.bottom, 16)

                    // CTA
                    Button {
                        Task {
                            await purchaseSelectedPlan()
                        }
                    } label: {
                        Text(isPurchasing ? purchaseInProgressLabel : s.shCta)
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
                    .disabled(isPurchasing || selectedProduct == nil)
                    .opacity((isPurchasing || selectedProduct == nil) ? 0.65 : 1.0)

                    // Restore
                    Button {
                        Task {
                            await restorePurchases()
                        }
                    } label: {
                        Text(s.shRestore)
                            .font(.system(size: 13))
                            .foregroundColor(Color(hex: "#636366"))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 6)
                    }
                    .buttonStyle(.plain)

                    Text(s.proMicroCopy)
                        .font(.system(size: 11))
                        .foregroundColor(Color(hex: "#636366"))
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 6)

                    Text(s.legalAutoRenew)
                        .font(.system(size: 10))
                        .foregroundColor(Color(hex: "#8e8e93"))
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 8)

                    Text(s.legalManage)
                        .font(.system(size: 10))
                        .foregroundColor(Color(hex: "#8e8e93"))
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 4)

                    HStack(spacing: 14) {
                        Button {
                            openLegalLink(termsURL)
                        } label: {
                            Text(s.legalTerms)
                                .font(.system(size: 11, weight: .semibold))
                                .foregroundColor(Color(hex: "#f5c518"))
                        }
                        .buttonStyle(.plain)

                        Text("•")
                            .foregroundColor(Color(hex: "#636366"))

                        Button {
                            openLegalLink(privacyURL)
                        } label: {
                            Text(s.legalPrivacy)
                                .font(.system(size: 11, weight: .semibold))
                                .foregroundColor(Color(hex: "#f5c518"))
                        }
                        .buttonStyle(.plain)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 8)

                    if isLoadingProducts {
                        ProgressView()
                            .tint(Color(hex: "#f5c518"))
                            .frame(maxWidth: .infinity)
                            .padding(.top, 8)
                    }
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
        .task {
            await loadProducts()
            await refreshProStatus()
        }
    }

    private var selectedProduct: Product? {
        switch selectedPlan {
        case .monthly:
            return monthlyProduct
        case .yearly:
            return yearlyProduct
        }
    }

    private var purchaseInProgressLabel: String {
        switch appState.language {
        case "tr":
            return "İşleniyor..."
        case "de":
            return "Wird verarbeitet..."
        default:
            return "Processing..."
        }
    }

    private var purchaseSuccessLabel: String {
        switch appState.language {
        case "tr":
            return "GlowCall Pro aktif edildi"
        case "de":
            return "GlowCall Pro wurde aktiviert"
        default:
            return "GlowCall Pro activated"
        }
    }

    private var purchaseFailedLabel: String {
        switch appState.language {
        case "tr":
            return "Satın alma tamamlanamadı"
        case "de":
            return "Kauf konnte nicht abgeschlossen werden"
        default:
            return "Purchase could not be completed"
        }
    }

    private var restoreSuccessLabel: String {
        switch appState.language {
        case "tr":
            return "Satın alımlar geri yüklendi"
        case "de":
            return "Käufe wiederhergestellt"
        default:
            return "Purchases restored"
        }
    }

    @MainActor
    private func loadProducts() async {
        isLoadingProducts = true
        defer { isLoadingProducts = false }

        do {
            let products = try await Product.products(for: [monthlyProductID, yearlyProductID])
            monthlyProduct = products.first { $0.id == monthlyProductID }
            yearlyProduct = products.first { $0.id == yearlyProductID }
        } catch {
            appState.showToast(purchaseFailedLabel)
        }
    }

    @MainActor
    private func purchaseSelectedPlan() async {
        guard let product = selectedProduct else { return }
        isPurchasing = true
        defer { isPurchasing = false }

        do {
            let result = try await product.purchase()
            switch result {
            case .success(let verificationResult):
                switch verificationResult {
                case .verified(let transaction):
                    await transaction.finish()
                    await refreshProStatus()
                    appState.showPremiumSheet = false
                    appState.showToast(purchaseSuccessLabel)
                case .unverified:
                    appState.showToast(purchaseFailedLabel)
                }
            case .pending:
                appState.showToast(purchaseInProgressLabel)
            case .userCancelled:
                break
            @unknown default:
                break
            }
        } catch {
            appState.showToast(purchaseFailedLabel)
        }
    }

    @MainActor
    private func restorePurchases() async {
        do {
            try await AppStore.sync()
            await refreshProStatus()
            appState.showToast(restoreSuccessLabel)
        } catch {
            appState.showToast(purchaseFailedLabel)
        }
    }

    @MainActor
    private func refreshProStatus() async {
        var hasActivePro = false
        for await verificationResult in Transaction.currentEntitlements {
            if case .verified(let transaction) = verificationResult,
               (transaction.productID == monthlyProductID || transaction.productID == yearlyProductID),
               transaction.revocationDate == nil {
                hasActivePro = true
                break
            }
        }
        appState.isPro = hasActivePro
    }

    private func openLegalLink(_ url: URL?) {
        guard let url else {
            appState.showToast(purchaseFailedLabel)
            return
        }
        openURL(url)
    }
}

struct FeatureRow: View {
    let text: String

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text("•")
                .foregroundColor(Color(hex: "#f5c518"))
            Text(text)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(Color(hex: "#f2f2f7"))
                .fixedSize(horizontal: false, vertical: true)
            Spacer(minLength: 0)
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
    var isSelected: Bool = false

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
        .background(isSelected ? Color(hex: "#232323") : Color(hex: "#1a1a1a"))
        .cornerRadius(14)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(
                    isSelected ? Color(hex: "#f5c518") : (isBest ? Color(hex: "#f5c518").opacity(0.45) : Color.white.opacity(0.09)),
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
