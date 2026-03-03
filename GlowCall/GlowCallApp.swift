import SwiftUI

@main
struct GlowCallApp: App {
    @State private var appState = AppState()
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(appState)
                .onOpenURL { url in
                    if url.scheme == "glowcall" && url.host == "flash" {
                        appState.isFlashActive = true
                    }
                }
        }
       
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .active {
                let active = UserDefaults(suiteName: "group.com.selin.glowcall")?.bool(forKey: "gc_active") ?? false
                if active {
                    appState.isFlashActive = true
                }
            }
        }
    }
}
