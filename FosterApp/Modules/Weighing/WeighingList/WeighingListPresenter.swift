//  WeighingListPresenter.swift
//
//  Created by Elora on 09/07/2023.
//

/// `WeighingListPresenter` acts as the middleman between the `WeighingListInteractor` and `WeighingListViewModel`.
/// It processes weighing data received from the interactor and updates the ViewModel.
class WeighingListPresenter: Presenter<WeighingListViewModel> {
	
	/// Updates the ViewModel with weighing data and triggers the view controller's UI refresh.
	/// - Parameter weighings: An array of `Weighing` objects to be displayed in the view.
	func display(weighings: [Weighing]) {
		// Implementation for updating ViewModel with weighings data
		self.viewModel?.weights = weighings
		self.viewModel?.send()
	}
}
