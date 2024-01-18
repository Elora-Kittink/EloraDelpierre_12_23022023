//  LitterHistoryPresenter.swift
//
//  Created by Elora on 27/02/2023.
//

/// `LitterHistoryPresenter` acts as the middleman between the `LitterHistoryInteractor` and `LitterHistoryViewModel`.
/// It processes data received from the interactor and updates the ViewModel.
class LitterHistoryPresenter: Presenter<LitterHistoryViewModel> {
    
	/// Updates the ViewModel with a list of litters.
	/// - Parameter litters: An array of `Litter` objects to be displayed.
    func display(litters: [Litter]) {
        self.viewModel?.litters = litters
		self.viewModel?.send()
    }
    
	/// Updates the ViewModel with details of a specific litter.
	/// - Parameter litter: The `Litter` object to be displayed in detail.
    func displayCell(litter: Litter) {
        self.viewModel?.kittenList = litter.kittens?.compactMap { kitten in
            kitten.firstName
        }
        .joined(separator: ", ") ?? "Pas encore de chaton"
		self.viewModel?.send()
    }
}
