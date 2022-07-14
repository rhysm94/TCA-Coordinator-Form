//
//  AppCoordinator.swift
//  TCA-Coordinator-Form
//
//  Created by Rhys Morgan on 14/07/2022.
//

import ComposableArchitecture
import TCACoordinators

struct AppCoordinatorState: IdentifiedRouterState, Equatable {
	static let initialState = Self(routes: [.root(.step1(Step1State()), embedInNavigationView: true)])

	var routes: IdentifiedArrayOf<Route<AppFlowState>>
}

enum AppCoordinatorAction: IdentifiedRouterAction {
	case updateRoutes(IdentifiedArrayOf<Route<AppFlowState>>)
	case routeAction(AppFlowState.ID, action: AppFlowAction)
}

typealias AppCoordinatorReducer = Reducer<AppCoordinatorState, AppCoordinatorAction, AppFlowEnvironment>

extension AppCoordinatorReducer {
	static let appCoordinator = AppFlowReducer.appFlow
		.forEachIdentifiedRoute(environment: { $0 })
		.withRouteReducer(Reducer { state, action, _ in
			switch action {
			case .routeAction(_, action: .step1(.nextButtonTapped)):
				state.routes.push(.step2(Step2State()))
				return .none

			case .routeAction(_, action: .step2(.nextButtonTapped)):
				state.routes.push(.step3(Step3State()))
				return .none

			default:
				return .none
			}
		})
}

