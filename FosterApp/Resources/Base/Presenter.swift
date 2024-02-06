//  Presenter.swift
//
//  Created by Elora on 27/02/2023.
//

import Foundation

/// `Presenter` is responsible for preparing data for display (i.e., updating the ViewModel) and reacting to user inputs.
@MainActor 
class Presenter<V: ViewModel> {
	
	// MARK: Variables
	private let identifier = UUID().uuidString
	var viewModel: V?
	
	// MARK: - Init
	required init() { }

	/// Sets the ViewModel.
	func set(viewModel: V) {
		self.viewModel = viewModel
	}
	
	// MARK: - Display
	/// Updates the loading state in the ViewModel.
	func display(loader: Bool) {
		self.viewModel?.isLoading = loader
		self.viewModel?.send()
	}
	
	// MARK: - Close
	func close() {
		/// Signals the ViewModel to close the view.
		self.viewModel?.needToClose = true
		self.viewModel?.send()
	}
}
