//  LitterInteractor.swift
//
//  Created by Elora on 24/02/2023.
//

import Foundation
import UIKit

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
            //                self.presenter.displayMode(litter: litter)
            self.presenter.display(loader: false)
        }
    }
    
    
    
    func edit() {
        self.presenter.editMode()
    }
    
    func createNewLitter() {
        
//        worker.updateLitterDB(litter: <#T##Litter#>)
    }
    
    func archiveLitter(litterId: String) {
        //        self.presenter.display(loader: true)
        //        Task {
        //
        //        }
    }
    
    func displayDate(date: Date) {
        self.presenter.displayDate(date: date)
        
    }
}
