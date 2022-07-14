//
//  Step2.swift
//  TCA-Coordinator-Form
//
//  Created by Rhys Morgan on 12/07/2022.
//

import ComposableArchitecture
import SwiftUI

struct Step2View: View {
	let store: Store<Step2State, Step2Action>

	var body: some View {
		WithViewStore(store) { viewStore in
			Form {
				Section {
					DatePicker(
						"Date of Birth",
						selection: viewStore.binding(\.$dateOfBirth),
						in: ...Date.now,
						displayedComponents: .date
					)
					.datePickerStyle(.graphical)
				} header: {
					Text("Date of Birth")
				}
			}
			.navigationTitle("Step 2")
		}
	}
}

struct Step2View_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			Step2View(
				store: Store(
					initialState: Step2State(),
					reducer: .step2,
					environment: Step2Environment(mainQueue: .main)
				)
			)
		}
	}
}

public struct Step2State: Equatable {
	@BindableState var dateOfBirth: Date = .now
}

public enum Step2Action: BindableAction {
	case binding(BindingAction<Step2State>)
	case nextButtonTapped
}

struct Step2Environment {
	let mainQueue: AnySchedulerOf<DispatchQueue>
}

typealias Step2Reducer = Reducer<Step2State, Step2Action, Step2Environment>

extension Step2Reducer {
	static let step2 = Reducer.empty.binding()
}
