//  Presenter.swift
//
//  Created by Elora on 27/02/2023.
//

import Foundation

@MainActor class Presenter<V: ViewModel> {
	
	// MARK: Variables
	private let identifier = UUID().uuidString
	var viewModel: V?
	
	// MARK: - Init
	required init() { }
	
	func set(viewModel: V) {
		self.viewModel = viewModel
	}
	
	// MARK: - Display
	func display(loader: Bool) {
		self.viewModel?.isLoading = loader
		self.viewModel?.send()
	}
	
	// MARK: - Close
	func close() {
		self.viewModel?.needToClose = true
		self.viewModel?.send()
	}
}
