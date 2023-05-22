//  LitterHistoryInteractor.swift
//
//  Created by Elora on 27/02/2023.
//

class LitterHistoryInteractor: Interactor
<
    LitterHistoryViewModel,
    LitterHistoryPresenter
> {
    
    let worker = DBWorker()
    
    func refresh(user: User) {
        Task {
            let litters = worker.fetchAllLitters(userId: user.id)
            self.presenter.display(litters: litters)
            self.presenter.display(loader: false)
        }
    }
    
    func refreshCell(litter: Litter?) {
        guard let litter else { return }
        self.presenter.displayCell(litter: litter)
    }
}
