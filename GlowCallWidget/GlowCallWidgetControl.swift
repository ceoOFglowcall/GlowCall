import AppIntents
import SwiftUI
import WidgetKit

struct GlowCallWidgetControl: ControlWidget {
    var body: some ControlWidgetConfiguration {
        StaticControlConfiguration(
            kind: "com.selin.glowcall.GlowCall.GlowCallWidget",
            provider: Provider()
        ) { isActive in
            ControlWidgetToggle(
                "GlowCall",
                isOn: isActive,
                action: ToggleGlowIntent()
            ) { isOn in
                Label(
                    isOn ? "Işık Açık" : "GlowCall",
                    systemImage: isOn ? "light.max" : "light.min"
                )
            }
        }
        .displayName("GlowCall")
        .description("Görüntülü görüşmeler için ışık paneli.")
    }
}

extension GlowCallWidgetControl {
    struct Provider: ControlValueProvider {
        var previewValue: Bool { false }

        func currentValue() async throws -> Bool {
            UserDefaults(suiteName: "group.com.selin.glowcall")?.bool(forKey: "gc_active") ?? false
        }
    }
}

struct ToggleGlowIntent: SetValueIntent {
    static let title: LocalizedStringResource = "GlowCall Işığını Aç/Kapat"
    static let openAppWhenRun: Bool = true

    @Parameter(title: "Işık aktif")
    var value: Bool

    func perform() async throws -> some IntentResult {
        UserDefaults(suiteName: "group.com.selin.glowcall")?.set(value, forKey: "gc_active")
        ControlCenter.shared.reloadControls(ofKind: "com.selin.glowcall.GlowCall.GlowCallWidget")
        return .result()
    }
}
