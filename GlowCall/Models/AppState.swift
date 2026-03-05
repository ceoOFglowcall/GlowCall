import SwiftUI
import WidgetKit
import Combine

// MARK: - Preset Model
struct ColorPreset {
    let id: String
    let color: Color
    let warmth: Int
    let isFree: Bool
    let nameTR: String
    let nameEN: String
    let nameDE: String

    func name(lang: String) -> String {
        switch lang {
        case "tr":
            return nameTR
        case "de":
            return nameDE
        default:
            return nameEN
        }
    }
}

// MARK: - Presets
let PRESETS: [ColorPreset] = [
    ColorPreset(id: "cool",   color: Color(hex: "#eef4ff"), warmth: 5,  isFree: true,  nameTR: "Soğuk Beyaz", nameEN: "Cool White",    nameDE: "Kaltweiß"),
    ColorPreset(id: "neu",    color: Color(hex: "#fff9ee"), warmth: 35, isFree: false, nameTR: "Nötr Beyaz",  nameEN: "Neutral White", nameDE: "Neutralweiß"),
    ColorPreset(id: "warm",   color: Color(hex: "#ffe580"), warmth: 70, isFree: false, nameTR: "Sıcak Sarı",  nameEN: "Warm Yellow",   nameDE: "Warmgelb"),
    ColorPreset(id: "golden", color: Color(hex: "#ffc85a"), warmth: 92, isFree: false, nameTR: "Altın",       nameEN: "Golden",        nameDE: "Gold"),
]

// MARK: - AppState
@Observable
class AppState {
    private static let defaultBrightness: Double = 80


    // MARK: Kalıcı (UserDefaults)
    var hasSeenOnboarding: Bool {
        didSet { UserDefaults.standard.set(hasSeenOnboarding, forKey: "gc_seen") }
    }
    var language: String {
        didSet { UserDefaults.standard.set(language, forKey: "gc_lang") }
    }
    var selectedPresetIndex: Int {
        didSet { UserDefaults.standard.set(selectedPresetIndex, forKey: "gc_preset") }
    }
    var brightness: Double
    var eyeMode: Bool

    // MARK: Oturum bazlı
    var warmth: Double = 5
    var timerMinutes: Int = 0
    var timerSecondsRemaining: Int = 0
    var isPro: Bool = false
    var isFlashActive: Bool = false {
        didSet {
            UserDefaults(suiteName: "group.com.selin.glowcall")?.set(isFlashActive, forKey: "gc_active")
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
    var showControls: Bool = false
    var showPremiumSheet: Bool = false
    var showBatterySheet: Bool = false
    var toastMessage: String? = nil

    // MARK: Init
    init() {
        self.hasSeenOnboarding = UserDefaults.standard.bool(forKey: "gc_seen")
        let systemLang = Locale.current.language.languageCode?.identifier ?? "en"
        let defaultLang = ["tr", "de"].contains(systemLang) ? systemLang : "en"
        self.language = UserDefaults.standard.string(forKey: "gc_lang") ?? defaultLang
        let storedPresetIndex = UserDefaults.standard.object(forKey: "gc_preset") as? Int ?? 0
        self.selectedPresetIndex = Self.safePresetIndex(storedPresetIndex)

        self.brightness = Self.defaultBrightness
        self.eyeMode = false

        self.warmth = Double(PRESETS[selectedPresetIndex].warmth)
    }

    // MARK: Helpers
    var selectedPreset: ColorPreset { PRESETS[Self.safePresetIndex(selectedPresetIndex)] }
    var s: GCStrings { GCStrings.strings(lang: language) }

    func selectPreset(_ index: Int) {
        guard PRESETS.indices.contains(index) else { return }
        guard PRESETS[index].isFree || isPro else {
            showPremiumSheet = true
            return
        }
        selectedPresetIndex = index
        warmth = Double(PRESETS[index].warmth)
    }

    func showToast(_ message: String) {
        toastMessage = message
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.4) {
            self.toastMessage = nil
        }
    }

    // MARK: Flash Color
    func flashColor() -> Color {
        let preset = selectedPreset
        let hex = preset.color
        let t = warmth / 100.0

        let (r, g, b) = hex.rgbComponents()

        let fr = r + (255 - r) * t * 0.35
        let fg = g + (176 - g) * t * 0.25
        let fb = b + (48  - b) * t * 0.4

        if eyeMode {
            return Color(
                red:   min(255, fr + 8)       / 255,
                green: min(255, fg + 3)        / 255,
                blue:  min(255, fb * 0.93)     / 255
            )
        }

        return Color(
            red:   min(255, fr) / 255,
            green: min(255, fg) / 255,
            blue:  min(255, fb) / 255
        )
    }

    // MARK: Warmth label
    func warmthLabel() -> String {
        if Self.safePresetIndex(selectedPresetIndex) == 0 { return "—" }
        switch warmth {
        case ..<25:  return s.warmCool
        case ..<55:  return s.warmNeu
        case ..<80:  return s.warmWarm
        default:     return s.warmGolden
        }
    }

    private static func safePresetIndex(_ index: Int) -> Int {
        guard PRESETS.indices.contains(index) else { return 0 }
        return index
    }
}

// MARK: - Color Hex Extension
extension Color {
    init(hex: String) {
        let h = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: h).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8)  & 0xFF) / 255
        let b = Double(int         & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }

    func rgbComponents() -> (Double, Double, Double) {
        let uiColor = UIColor(self)
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        uiColor.getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r * 255, g * 255, b * 255)
    }
}

