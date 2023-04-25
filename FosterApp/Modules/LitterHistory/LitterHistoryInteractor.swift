//  LitterHistoryInteractor.swift
//
//  Created by Elora on 27/02/2023.
//

class LitterHistoryInteractor: Interactor
<
    LitterHistoryViewModel,
    LitterHistoryPresenter
> {
    
    let worker = Worker()
    
    func refresh(user: User) {
        Task {
            let litters = worker.fetchAllLitters(userId: user.id)
            self.presenter.display(litters: litters)
            self.presenter.display(loader: false)
        }
    }
}
