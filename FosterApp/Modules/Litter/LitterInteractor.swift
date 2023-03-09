//  LitterInteractor.swift
//
//  Created by Elora on 24/02/2023.
//

import Foundation

class LitterInteractor: Interactor
<
	LitterViewModel,
	LitterPresenter
> {
    
    let worker = Worker()
    
    func refresh(litterId: String) {
        
            self.presenter.display(loader: true)
            Task {
                guard let litter = worker.fetchLitterFromId(litterId: litterId) else {
//                    on fait quoi si on a pas de portée à afficher?
                    return
                }
//                self.presenter.display(litter: litter)
                self.presenter.display(loader: false)
            }
        }
        
    
    
    func edit() {
        
    }
    
    func createNewKitten() {
        
    }
    
    func archiveLitter(litterId: String) {
//        self.presenter.display(loader: true)
//        Task {
//
//        }
    }
}
