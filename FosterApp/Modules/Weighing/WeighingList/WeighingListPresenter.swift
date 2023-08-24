//  WeighingListPresenter.swift
//
//  Created by Elora on 09/07/2023.
//

class WeighingListPresenter: Presenter<WeighingListViewModel> {
	
	func display(weighings: [Weighing]) {
		self.viewModel?.weights = weighings
		self.viewModel?.send()
	}
}
