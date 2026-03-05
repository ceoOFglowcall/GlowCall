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
    let proFeature1: String
    let proFeature2: String
    let proFeature3: String
    let proMicroCopy: String
    let freeBadge: String
    let legalAutoRenew: String
    let legalManage: String
    let legalTerms: String
    let legalPrivacy: String
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
        flashHint:      "Tek dokun: kontroller · Çift dokun: kapat",
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
        obHeading:      "10 saniyede daha iyi görün.",
        obSub:          "GlowCall ekranını yumuşak bir ışık paneline çevirir; gece görüntülü aramalarda yüzün daha net görünür.",
        ob1t:           "Bir rengi seç",
        ob1p:           "Tenine uygun tonu seç, parlaklığı tek kaydırıcıyla ayarla.",
        ob2t:           "Görüşmeyi başlat",
        ob2p:           "FaceTime, WhatsApp veya Instagram aramasını başlat ve GlowCall'a geç.",
        ob3t:           "Işığı aç, görünümünü toparla",
        ob3p:           "Işığı açınca yüzün daha dengeli aydınlanır. Özellikle düşük ışıkta daha net ve profesyonel görünürsün.",
        ob3pip:         "Görüşme ekranı küçülmezse Ayarlar uygulamasında 'Resim İçinde Resim (PiP)' seçeneğinin açık olduğundan emin ol.",
        ob3note:        "Not:",
        ob3more:        "Daha fazla göster",
        ob3less:        "Daha az göster",
        obTrial:        "₺50/ay · ₺500/yıl",
        obCta:          "Hemen Başla",
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
        pro:            "✦ GlowCall Pro ile daha iyi görün",
        shTitle:        "Her aramada daha iyi görün",
        shSub:          "GlowCall Pro, ışığını ortama daha hızlı uydurur.",
        shMonthly:      "Aylık",
        shMo:           "/ay",
        shYearly:       "Yıllık",
        shYr:           "/yıl",
        shTrial:        "",
        shBest:         "En iyi değer",
        shCta:          "Pro'ya Geç",
        shRestore:      "Satın alımı geri yükle",
        proFeature1:    "Sıcaklık ince ayarı ile tonu kendine göre ayarla",
        proFeature2:    "Tüm premium renk presetlerinin kilidini aç",
        proFeature3:    "Gece görüşmelerinde daha dengeli ve yumuşak ışık",
        proMicroCopy:   "İptal etmesi kolay. Özellikler düzenli olarak güncellenir.",
        freeBadge:      "ÜCRETSİZ",
        legalAutoRenew: "Abonelikler otomatik yenilenir. Dönem bitiminden en az 24 saat önce iptal edilmezse yenileme gerçekleşir.",
        legalManage:    "Aboneliklerini satın alma sonrası Ayarlar > Apple Kimliği > Abonelikler bölümünden yönetebilirsin.",
        legalTerms:     "Kullanım Koşulları",
        legalPrivacy:   "Gizlilik Politikası",
        eyeProtection:  "Göz Koruma Modu",
        brSliderLabel:  "Parlaklık"
    )

    // MARK: - İngilizce
    static let english = GCStrings(
        flashHint:      "Single tap: controls · Double tap: close",
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
        obHeading:      "Look better in 10 seconds.",
        obSub:          "GlowCall turns your screen into a soft light panel so your face stays clear in low-light calls.",
        ob1t:           "Pick your light",
        ob1p:           "Choose a tone that fits your skin and set brightness with one slider.",
        ob2t:           "Start your call",
        ob2p:           "Start on FaceTime, WhatsApp, or Instagram, then switch to GlowCall.",
        ob3t:           "Turn light on, look camera-ready",
        ob3p:           "With one tap, your face looks more balanced and clear, especially in dark rooms.",
        ob3pip:         "If the call screen does not shrink, make sure 'Picture in Picture (PiP)' is enabled in the Settings app.",
        ob3note:        "Note:",
        ob3more:        "Show more",
        ob3less:        "Show less",
        obTrial:        "$3.99/mo · $39.99/yr",
        obCta:          "Start Now",
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
        pro:            "✦ GlowCall Pro for better calls",
        shTitle:        "Look better on every call",
        shSub:          "GlowCall Pro helps you match your lighting faster.",
        shMonthly:      "Monthly",
        shMo:           "/mo",
        shYearly:       "Yearly",
        shYr:           "/yr",
        shTrial:        "",
        shBest:         "Best value",
        shCta:          "Upgrade to Pro",
        shRestore:      "Restore purchase",
        proFeature1:    "Fine-tune warmth to match your tone",
        proFeature2:    "Unlock every premium color preset",
        proFeature3:    "Smoother, balanced lighting for night calls",
        proMicroCopy:   "Easy to cancel. New features added regularly.",
        freeBadge:      "FREE",
        legalAutoRenew: "Subscriptions auto-renew unless canceled at least 24 hours before the current period ends.",
        legalManage:    "Manage your subscription anytime in Settings > Apple ID > Subscriptions after purchase.",
        legalTerms:     "Terms of Use",
        legalPrivacy:   "Privacy Policy",
        eyeProtection:  "Eye Protection",
        brSliderLabel:  "Brightness"
    )
    // MARK: - Almanca
        static let german = GCStrings(
            flashHint:      "Einmal tippen: Steuerung · Doppeltippen: schließen",
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
            obHeading:      "In 10 Sekunden besser aussehen.",
            obSub:          "GlowCall macht aus deinem Display ein weiches Lichtpanel für klare Videoanrufe bei wenig Licht.",
            ob1t:           "Lichtfarbe wählen",
            ob1p:           "Wähle einen Ton, der zu dir passt, und stelle die Helligkeit mit einem Regler ein.",
            ob2t:           "Anruf starten",
            ob2p:           "Starte auf FaceTime, WhatsApp oder Instagram und wechsle dann zu GlowCall.",
            ob3t:           "Licht aktivieren, besser wirken",
            ob3p:           "Mit einem Tippen wirkt dein Gesicht ausgeglichener und klarer, besonders in dunklen Räumen.",
            ob3pip:         "Wenn sich der Anrufbildschirm nicht verkleinert, stelle sicher, dass 'Bild in Bild (PiP)' in der Einstellungen-App aktiviert ist.",
            ob3note:        "Hinweis:",
            ob3more:        "Mehr anzeigen",
            ob3less:        "Weniger anzeigen",
            obTrial:        "€3,99/Monat · €39,99/Jahr",
            obCta:          "Jetzt starten",
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
            pro:            "✦ GlowCall Pro für bessere Calls",
            shTitle:        "Bei jedem Anruf besser aussehen",
            shSub:          "GlowCall Pro passt dein Licht schneller an jede Umgebung an.",
            shMonthly:      "Monatlich",
            shMo:           "/Monat",
            shYearly:       "Jährlich",
            shYr:           "/Jahr",
            shTrial:        "",
            shBest:         "Bestes Angebot",
            shCta:          "Auf Pro upgraden",
            shRestore:      "Kauf wiederherstellen",
            proFeature1:    "Farbtemperatur fein abstimmen",
            proFeature2:    "Alle Premium-Farbpresets freischalten",
            proFeature3:    "Ausgeglicheneres Licht für Nachtanrufe",
            proMicroCopy:   "Jederzeit kündbar. Regelmäßige Verbesserungen inklusive.",
            freeBadge:      "KOSTENLOS",
            legalAutoRenew: "Abonnements verlängern sich automatisch, sofern sie nicht mindestens 24 Stunden vor Ablauf gekündigt werden.",
            legalManage:    "Du kannst dein Abo nach dem Kauf jederzeit unter Einstellungen > Apple-ID > Abonnements verwalten.",
            legalTerms:     "Nutzungsbedingungen",
            legalPrivacy:   "Datenschutzrichtlinie",
            eyeProtection:  "Augenschutzmodus",
            brSliderLabel:  "Helligkeit"
        )
}
