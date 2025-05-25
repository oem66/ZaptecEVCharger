import SwiftUI
import SwiftyBeaver

let log = SwiftyBeaver.self

@main
struct iOSApp: App {
    @State private var navigationPath = NavigationPath()
    @State private var showOnboarding = true
    
    init() {
        let console = ConsoleDestination()
        log.addDestination(console)
    }
    
	var body: some Scene {
		WindowGroup {
            NavigationStack(path: $navigationPath) {
                if showOnboarding {
                    OnboardingView(navigationPath: $navigationPath,
                                   showOnboarding: $showOnboarding)
                } else {
                    ChargerView(navigationPath: $navigationPath)
                }
            }
		}
	}
}
