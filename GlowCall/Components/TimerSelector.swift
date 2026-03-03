import SwiftUI

struct TimerSelector: View {
    @Binding var selected: Int
    @Environment(AppState.self) private var appState

    let options: [(label: String, minutes: Int)] = [
        ("tOff", 0),
        ("t15",  15),
        ("t30",  30),
        ("t60",  60)
    ]

    var body: some View {
        HStack(spacing: 8) {
            ForEach(options, id: \.minutes) { opt in
                Button {
                    selected = opt.minutes
                } label: {
                    Text(label(for: opt.label))
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(selected == opt.minutes ? Color(hex: "#f2f2f7") : Color(hex: "#636366"))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 9)
                        .background(Color(hex: "#242424"))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(
                                    selected == opt.minutes ? Color(hex: "#f5c518") : Color.clear,
                                    lineWidth: 1.5
                                )
                        )
                }
                .buttonStyle(.plain)
                .animation(.easeInOut(duration: 0.2), value: selected)
            }
        }
    }

    func label(for key: String) -> String {
        let s = appState.s
        switch key {
        case "tOff": return s.tOff
        case "t15":  return s.t15
        case "t30":  return s.t30
        case "t60":  return s.t60
        default:     return key
        }
    }
}

#Preview {
    TimerSelector(selected: .constant(0))
        .environment(AppState())
        .padding()
        .background(Color.black)
}
