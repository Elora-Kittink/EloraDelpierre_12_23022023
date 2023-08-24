//  WeighingListInteractor.swift
//
//  Created by Elora on 09/07/2023.
//

class WeighingListInteractor: Interactor
<
	WeighingListViewModel,
	WeighingListPresenter
> {
	let worker = DBWorker()

	func refresh(kitten: Kitten) {
		Task {
			let weighings = worker.fetchWeighingFromKittenId(kittenId: kitten.id ?? "")
			self.presenter.display(weighings: weighings ?? [])
			self.presenter.display(loader: false)
		}
	}
}
