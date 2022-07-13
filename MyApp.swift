import ComposableArchitecture
import SwiftUI

@main
struct MyApp: App {
	let store = Store(
		initialState: Step1State(),
		reducer: .step1,
		environment: Step1Environment(mainQueue: .main)
	)

    var body: some Scene {
        WindowGroup {
			NavigationView {
				Step1View(store: store)
			}
        }
    }
}
