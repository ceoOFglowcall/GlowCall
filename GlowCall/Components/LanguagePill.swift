import SwiftUI

struct LanguagePill: View {
    @Environment(AppState.self) private var appState

    var body: some View {
        @Bindable var appState = appState

        HStack(spacing: 2) {
            ForEach(["tr", "en", "de"], id: \.self) { lang in
                Button {
                    appState.language = lang
                } label: {
                    Text(lang.uppercased())
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(appState.language == lang ? Color(hex: "#f2f2f7") : Color(hex: "#636366"))
                        .padding(.horizontal, 14)
                        .padding(.vertical, 5)
                        .background(
                            appState.language == lang
                                ? Color(hex: "#242424")
                                : Color.clear
                        )
                        .cornerRadius(16)
                }
            }
        }
        .padding(3)
        .background(Color(hex: "#1a1a1a"))
        .cornerRadius(20)
    }
}

#Preview {
    LanguagePill()
        .environment(AppState())
        .preferredColorScheme(.dark)
}
