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
		
	}
}
