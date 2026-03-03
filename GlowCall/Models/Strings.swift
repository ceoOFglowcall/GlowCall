import Foundation

struct GCStrings {
    let flashHint: String
    let close: String
    let battTitle: String
    let battSub: String
    let battDim: String
    let battOk: String
    let comingSoon: String
    let warmCool: String
    let warmNeu: String
    let warmWarm: String
    let warmGolden: String
    let wmLocked: String
    let wmHint: String
    let obHeading: String
    let obSub: String
    let ob1t: String
    let ob1p: String
    let ob2t: String
    let ob2p: String
    let ob3t: String
    let ob3p: String
    let ob3pip: String
    let ob3note: String
    let ob3more: String
    let ob3less: String
    let obTrial: String
    let obCta: String
    let presetTitle: String
    let brTitle: String
    let brLabel: String
    let wmTitle: String
    let wmLabel: String
    let timerTitle: String
    let timerLabel: String
    let tOff: String
    let t15: String
    let t30: String
    let t60: String
    let activate: String
    let howTo: String
    let pro: String
    let shTitle: String
    let shSub: String
    let shMonthly: String
    let shMo: String
    let shYearly: String
    let shYr: String
    let shTrial: String
    let shBest: String
    let shCta: String
    let shRestore: String
    let eyeProtection: String
    let brSliderLabel: String

    static func strings(lang: String) -> GCStrings {
        switch lang {
        case "tr": return .turkish
        case "de": return .german
        default:   return .english
        }
    }

    // MARK: - Türkçe
    static let turkish = GCStrings(
        flashHint:      "Dokunarak kontrol et · Çift dokun kapatmak için",
        close:          "Işığı Kapat",
        battTitle:      "Pil seviyesi düşük",
        battSub:        "Yüksek parlaklık bataryayı hızlı tüketiyor. Parlaklığı azaltmak ister misin?",
        battDim:        "Parlaklığı Azalt",
        battOk:         "Devam Et",
        comingSoon:     "Çok yakında! 🎉",
        warmCool:       "❄ Soğuk",
        warmNeu:        "● Nötr",
        warmWarm:       "🌡 Sıcak",
        warmGolden:     "✦ Altın",
        wmLocked:       "Sıcaklık ayarı Pro'ya özel ✦",
        wmHint:         "Presetin sıcaklık tonunu ayarla",
        obHeading:      "Karanlıkta da görün.",
        obSub:          "Görüntülü görüşmelerinde ekranını ışık paneline dönüştür.",
        ob1t:           "Parlaklığı artır",
        ob1p:           "Denetim Merkezi'ni aç, parlaklığı maksimuma çek.",
        ob2t:           "Görüşmeyi başlat",
        ob2p:           "FaceTime, WhatsApp ya da Instagram — görüşmeyi başlattıktan sonra GlowCall'a geç.",
        ob3t:           "Işığı aç, köşede izle",
        ob3p:           "Görüşme sırasında GlowCall'a geç ve ışığı aç. WhatsApp küçük bir pencerede köşede görünmeye devam eder. Yüzün aydınlanır, karşı tarafı da görürsün.",
        ob3pip:         "WhatsApp görüşme ekranı küçülmezse WhatsApp ayarlarından 'Resim içinde Resim'i etkinleştir.",
        ob3note:        "Not:",
        ob3more:        "Daha fazla göster",
        ob3less:        "Daha az göster",
        obTrial:        "₺50/ay · ₺500/yıl",
        obCta:          "Başla",
        presetTitle:    "Renk",
        brTitle:        "Parlaklık",
        brLabel:        "Parlaklık",
        wmTitle:        "İnce Ayar",
        wmLabel:        "Renk Sıcaklığı",
        timerTitle:     "Zamanlayıcı",
        timerLabel:     "Otomatik Kapat",
        tOff:           "Kapalı",
        t15:            "15 dk",
        t30:            "30 dk",
        t60:            "60 dk",
        activate:       "Işığı Aç",
        howTo:          "? Nasıl kullanılır",
        pro:            "✦ GlowCall Pro",
        shTitle:        "Tüm renklerin kilidini aç",
        shSub:          "Her ışık, her ortam.",
        shMonthly:      "Aylık",
        shMo:           "/ay",
        shYearly:       "Yıllık",
        shYr:           "/yıl",
        shTrial:        "",
        shBest:         "En iyi değer",
        shCta:          "Pro'ya Geç",
        shRestore:      "Satın alımı geri yükle",
        eyeProtection:  "Göz Koruma Modu",
        brSliderLabel:  "Parlaklık"
    )

    // MARK: - İngilizce
    static let english = GCStrings(
        flashHint:      "Tap to control · Double tap to close",
        close:          "Turn Off Light",
        battTitle:      "Low battery",
        battSub:        "High brightness drains battery quickly. Would you like to reduce it?",
        battDim:        "Reduce Brightness",
        battOk:         "Continue",
        comingSoon:     "Coming soon! 🎉",
        warmCool:       "❄ Cool",
        warmNeu:        "● Neutral",
        warmWarm:       "🌡 Warm",
        warmGolden:     "✦ Golden",
        wmLocked:       "Warmth adjustment is Pro only ✦",
        wmHint:         "Fine-tune the warmth of your preset",
        obHeading:      "Be seen, even in the dark.",
        obSub:          "Turn your screen into a light panel during video calls.",
        ob1t:           "Maximize brightness",
        ob1p:           "Open Control Center and drag brightness all the way up.",
        ob2t:           "Start your call",
        ob2p:           "FaceTime, WhatsApp or Instagram — open GlowCall after starting.",
        ob3t:           "Activate & stay here",
        ob3p:           "Switch to GlowCall during your call and activate the light. WhatsApp continues in a small floating window. Your face lights up — and you can still see the other person.",
        ob3pip:         "If the WhatsApp screen doesn't shrink, enable 'Picture in Picture' in WhatsApp settings.",
        ob3note:        "Note:",
        ob3more:        "Show more",
        ob3less:        "Show less",
        obTrial:        "$3.99/mo · $39.99/yr",
        obCta:          "Get Started",
        presetTitle:    "Color",
        brTitle:        "Brightness",
        brLabel:        "Brightness",
        wmTitle:        "Fine Tune",
        wmLabel:        "Color Temperature",
        timerTitle:     "Timer",
        timerLabel:     "Auto Off",
        tOff:           "Off",
        t15:            "15 min",
        t30:            "30 min",
        t60:            "60 min",
        activate:       "Activate Light",
        howTo:          "? How to use",
        pro:            "✦ GlowCall Pro",
        shTitle:        "Unlock all colors",
        shSub:          "Every light, every setting.",
        shMonthly:      "Monthly",
        shMo:           "/mo",
        shYearly:       "Yearly",
        shYr:           "/yr",
        shTrial:        "",
        shBest:         "Best value",
        shCta:          "Upgrade to Pro",
        shRestore:      "Restore purchase",
        eyeProtection:  "Eye Protection",
        brSliderLabel:  "Brightness"
    )
    // MARK: - Almanca
        static let german = GCStrings(
            flashHint:      "Tippen zum Steuern · Doppeltippen zum Schließen",
            close:          "Licht ausschalten",
            battTitle:      "Akku schwach",
            battSub:        "Hohe Helligkeit entlädt den Akku schnell. Möchtest du sie reduzieren?",
            battDim:        "Helligkeit reduzieren",
            battOk:         "Weiter",
            comingSoon:     "Bald verfügbar! 🎉",
            warmCool:       "❄ Kalt",
            warmNeu:        "● Neutral",
            warmWarm:       "🌡 Warm",
            warmGolden:     "✦ Golden",
            wmLocked:       "Farbtemperatur nur für Pro ✦",
            wmHint:         "Farbton des Presets anpassen",
            obHeading:      "Sichtbar bleiben, auch im Dunkeln.",
            obSub:          "Verwandle deinen Bildschirm in ein Lichtpanel für Videoanrufe.",
            ob1t:           "Helligkeit maximieren",
            ob1p:           "Öffne das Kontrollzentrum und ziehe die Helligkeit ganz nach oben.",
            ob2t:           "Anruf starten",
            ob2p:           "FaceTime, WhatsApp oder Instagram — starte den Anruf und wechsle dann zu GlowCall.",
            ob3t:           "Licht an, Anruf im Blick",
            ob3p:           "Wechsle während des Anrufs zu GlowCall und aktiviere das Licht. WhatsApp läuft weiter in einem kleinen schwebenden Fenster. Dein Gesicht wird beleuchtet — und du siehst die andere Person weiterhin.",
            ob3pip:         "Falls der WhatsApp-Bildschirm sich nicht verkleinert, aktiviere 'Bild in Bild' in den WhatsApp-Einstellungen.",
            ob3note:        "Hinweis:",
            ob3more:        "Mehr anzeigen",
            ob3less:        "Weniger anzeigen",
            obTrial:        "€3,99/Monat · €39,99/Jahr",
            obCta:          "Loslegen",
            presetTitle:    "Farbe",
            brTitle:        "Helligkeit",
            brLabel:        "Helligkeit",
            wmTitle:        "Feineinstellung",
            wmLabel:        "Farbtemperatur",
            timerTitle:     "Timer",
            timerLabel:     "Auto-Aus",
            tOff:           "Aus",
            t15:            "15 Min",
            t30:            "30 Min",
            t60:            "60 Min",
            activate:       "Licht aktivieren",
            howTo:          "? Anleitung",
            pro:            "✦ GlowCall Pro",
            shTitle:        "Alle Farben freischalten",
            shSub:          "Jedes Licht, jede Situation.",
            shMonthly:      "Monatlich",
            shMo:           "/Monat",
            shYearly:       "Jährlich",
            shYr:           "/Jahr",
            shTrial:        "",
            shBest:         "Bestes Angebot",
            shCta:          "Auf Pro upgraden",
            shRestore:      "Kauf wiederherstellen",
            eyeProtection:  "Augenschutzmodus",
            brSliderLabel:  "Helligkeit"
        )
}
