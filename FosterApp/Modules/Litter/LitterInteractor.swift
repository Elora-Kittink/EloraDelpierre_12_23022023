//  LitterInteractor.swift
//
//  Created by Elora on 24/02/2023.
//

import Foundation
import UIKit
import UtilsKit
import FirebaseCore
import FirebaseAuth

class LitterInteractor: Interactor
<
    LitterViewModel,
    LitterPresenter
> {
    
    let worker = DBWorker()
    
    func archiveLitter(litterId: String) {
        Task {
            worker.archiveLitter(litterId: litterId)
        }
    }
    
    func makeFavorite(litterId: String) {
        Task {
            worker.makeFavorite(litterId: litterId)
        }
    }
    
    
    func diplayMode(isEditing: Bool,
                    isCreating: Bool,
                    isDisplaying: Bool,
                    litterId: String?) {
        
        if isEditing && !isCreating && !isDisplaying {
            self.presenter.displayMode(type: LitterLayoutStyle.editing,
                                       rescueDate: nil,
                                       litterId: litterId,
                                       litter: nil,
                                       kittens: nil)
        }
        if !isEditing && isCreating && !isDisplaying {
            self.presenter.displayMode(type: LitterLayoutStyle.creating,
                                       rescueDate: nil,
                                       litterId: nil,
                                       litter: nil,
                                       kittens: nil)
        }
        if !isEditing && !isCreating && isDisplaying {
            self.presenter.displayMode(type: LitterLayoutStyle.displaying,
                                       rescueDate: nil,
                                       litterId: litterId,
                                       litter: nil,
                                       kittens: nil)
        }
    }
    
    func createLitter(user: User, rescueDate: Date?) {
        guard let rescueDate else {
            //                TODO: gérer l'absence de date
            return
        }
        Task {
            worker.createNewLitter(rescueDate: rescueDate, user: user)
        }
    }
    
    func refresh(litterId: String?) {
        Task {
            guard let litter = worker.fetchLitterFromId(litterId: litterId ?? "") else {
                return
            }
            let kittens = worker.fetchAllKittensLitter(litterId: litterId ?? "")
            self.presenter.displayMode(type: LitterLayoutStyle.displaying,
                                       rescueDate: litter.rescueDate?.toDate(format: "dd/MM/yyyy"),
                                       litterId: litterId,
                                       litter: litter,
                                       kittens: kittens)
            self.presenter.display(loader: false)
        }
    }
}
