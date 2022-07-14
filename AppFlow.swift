//
//  AppFlow.swift
//  TCA-Coordinator-Form
//
//  Created by Rhys Morgan on 14/07/2022.
//

import ComposableArchitecture

enum AppFlowState: Equatable, Identifiable {
	case step1(Step1State)
	case step2(Step2State)
	case step3(Step3State)
	case finalScreen(FinalScreenState)

	var id: ID {
		switch self {
		case .step1:
			return .step1
		case .step2:
			return .step2
		case .step3:
			return .step3
		case .finalScreen:
			return .finalScreen
		}
	}

	enum ID {
		case step1
		case step2
		case step3
		case finalScreen
	}
}

enum AppFlowAction: Equatable {
	case step1(Step1Action)
	case step2(Step2Action)
	case step3(Step3Action)
	case finalScreen(FinalScreenAction)
}

struct AppFlowEnvironment {
	let mainQueue: AnySchedulerOf<DispatchQueue>
	let getOccupations: () -> Effect<[String], Never>
	let submit: (APIModel) -> Effect<Bool, Never>
}

extension AppFlowEnvironment {
	var step1: Step1Environment {
		.init(mainQueue: mainQueue)
	}

	var step2: Step2Environment {
		.init(mainQueue: mainQueue)
	}

	var step3: Step3Environment {
		.init(mainQueue: mainQueue, getOccupations: getOccupations)
	}

	var finalScreen: FinalScreenEnvironment {
		.init(mainQueue: mainQueue, submit: submit)
	}
}

typealias AppFlowReducer = Reducer<AppFlowState, AppFlowAction, AppFlowEnvironment>

extension AppFlowReducer {
	static let appFlow = combine(
		Step1Reducer.step1
			.pullback(state: /AppFlowState.step1, action: /AppFlowAction.step1, environment: \.step1),
		Step2Reducer.step2
			.pullback(state: /AppFlowState.step2, action: /AppFlowAction.step2, environment: \.step2),
		Step3Reducer.step3
			.pullback(state: /AppFlowState.step3, action: /AppFlowAction.step3, environment: \.step3),
		FinalScreenReducer.finalScreen
			.pullback(state: /AppFlowState.finalScreen, action: /AppFlowAction.finalScreen, environment: \.finalScreen)
	)
}
