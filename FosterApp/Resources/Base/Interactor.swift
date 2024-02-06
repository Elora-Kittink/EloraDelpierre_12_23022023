//  Interactor.swift
//
//  Created by Elora on 27/02/2023.
//

import Foundation

/// `Interactor` is a main actor class responsible for handling business logic in the application.
/// It communicates with the Presenter to update the ViewModel.
@MainActor 
class Interactor<V: ViewModel, P: Presenter<V>> {
	
	// MARK: - Variables
	let presenter: P
	
	// MARK: - Init
	required init() {
		self.presenter = P()
	}
	
	/// Sets the ViewModel for the Presenter.
	func set(viewModel: V) {
		self.presenter.set(viewModel: viewModel)
	}
}
