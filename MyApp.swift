import ComposableArchitecture
import SwiftUI
import TCACoordinators

@main
struct MyApp: App {
	let store = Store(
		initialState: AppCoordinatorState.initialState,
		reducer: .appCoordinator,
		environment: AppFlowEnvironment(
			mainQueue: .main,
			getOccupations: {
				.task {
					[
						"iOS Developer",
						"Android Developer",
						"Web Developer",
						"Project Manager",
						"Designer",
						"The Big Cheese"
					]
				}
			}
		)
	)

    var body: some Scene {
        WindowGroup {
			TCARouter(store) { screen in
				SwitchStore(screen) {
					CaseLet(state: /AppFlowState.step1, action: AppFlowAction.step1, then: Step1View.init(store:))

					CaseLet(state: /AppFlowState.step2, action: AppFlowAction.step2, then: Step2View.init(store:))
					
					CaseLet(state: /AppFlowState.step3, action: AppFlowAction.step3, then: Step3View.init(store:))
				}
			}
        }
    }
}
