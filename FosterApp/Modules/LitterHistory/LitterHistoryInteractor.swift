//  LitterHistoryInteractor.swift
//
//  Created by Elora on 27/02/2023.
//

/// `LitterHistoryInteractor` handles the business logic for the `LitterHistoryViewController`.
class LitterHistoryInteractor: Interactor
<
    LitterHistoryViewModel,
    LitterHistoryPresenter
> {
    
    let worker = DBWorker()
	var userWorker: UserWorkerProtocol = UserWorker()
    
	/// Refreshes the litter history for a given user.
	/// - Parameter user: The `User` for whom the litter history is being refreshed.
    func refresh() {
        Task {
			guard let user = userWorker.retrieveUser() else { return }
			
			let litters = worker.fetchAllLitters(user: user)
            self.presenter.display(litters: litters)
            self.presenter.display(loader: false)
        }
    }
    
	/// Refreshes a specific litter cell.
	/// - Parameter litter: The `Litter` to be refreshed in the cell.
    func refreshCell(litter: Litter?) {
        guard let litter else {
            self.presenter.display(loader: false)
            return
        }
        self.presenter.displayCell(litter: litter)
        self.presenter.display(loader: false)
    }
}
