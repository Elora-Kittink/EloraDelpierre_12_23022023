//  WeighingListInteractor.swift
//
//  Created by Elora on 09/07/2023.
//

/// `WeighingListInteractor` handles the business logic for the `WeighingListViewController`.
/// It fetches and provides weighing data for a specific kitten.
class WeighingListInteractor: Interactor
<
	WeighingListViewModel,
	WeighingListPresenter
> {
	let worker = DBWorker()

	/// Fetches weighing data from the database for a given kitten.
	/// - Parameter kitten: The `Kitten` object for which weighings are being fetched.
	func refresh(kitten: Kitten) {
		Task {
			let weighings = worker.fetchWeighingFromKittenId(kittenId: kitten.id ?? "")
			self.presenter.display(weighings: weighings ?? [])
			self.presenter.display(loader: false)
		}
	}
}
