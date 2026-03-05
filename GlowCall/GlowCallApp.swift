import SwiftUI
import Combine

@main
struct GlowCallApp: App {
    @State private var appState = AppState()
    @Environment(\.scenePhase) private var scenePhase
    private let widgetSyncTimer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(appState)
                .onOpenURL { url in
                    if url.scheme == "glowcall" && url.host == "flash" {
                        appState.isFlashActive = true
                    }
                }
                .onAppear {
                    syncFlashStateFromWidget()
                }
                .onReceive(widgetSyncTimer) { _ in
                    syncFlashStateFromWidget()
                }
        }
       
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .active {
                syncFlashStateFromWidget()
            }
        }
    }

    private func syncFlashStateFromWidget() {
        let active = UserDefaults(suiteName: "group.com.selin.glowcall")?.bool(forKey: "gc_active") ?? false
        if appState.isFlashActive != active {
            appState.isFlashActive = active
        }
    }
}
