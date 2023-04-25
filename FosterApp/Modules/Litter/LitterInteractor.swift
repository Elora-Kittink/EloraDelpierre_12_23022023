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
    
    let worker = Worker()
    
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
    
    
    func refresh(litterId: String?,
                 rescueDate: Date?,
                 isCreating: Bool,
                 user: User?) {
        if isCreating {
            guard let date = rescueDate else {
                //                TODO: gérer l'absence de date
                return
            }
            guard let user else {
                //                TODO: gérer l'absence de User
                return
            }
            Task {
                worker.createNewLitter(rescueDate: date, user: user)
            }
        } else {
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
}
