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
        
//        self.presenter.display(loader: true)
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
    
    func createOrUpdateLitter(rescueDate: String?, editingMode: Bool, litterId: String?) {
        
        if editingMode {
            guard let date = rescueDate else {
                return
            }
            guard let id = litterId else {
                return
            }
//            self.presenter.display(loader: true)
            Task {
                worker.updateLitterDB(litterId: id, rescueDate: date)
            }
            self.presenter.display(loader: false)
        }
        
        if !editingMode {
            guard let date = rescueDate else {
                return
            }
//            self.presenter.display(loader: true)
            Task {
                worker.createNewLitter(rescueDate: date)
            }
            self.presenter.display(loader: false)
        }

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
    
//    MARK: ZONE DE TEST
    
    func fonctiondaffichage(isEditing: Bool, isCreating: Bool, isDisplaying: Bool, litterId: String) {
        
        self.presenter.displayMode(isEditing: isEditing, isCreating: isCreating, isDisplaying: isDisplaying, litterId: litterId)
        
    }
    
    
    func megafonction(isEditing: Bool, isCreating: Bool, isDisplaying: Bool, litterId: String?, rescueDate: String?) {
        
        if isDisplaying {
            
//            self.presenter.display(loader: true)
            Task {
                guard let litter = worker.fetchLitterFromId(litterId: litterId ?? "") else {
                    //                    on fait quoi si on a pas de portée à afficher?
                    return
                }
                //                self.presenter.displayMode(litter: litter)
                self.presenter.display(loader: false)
            }
        }
        
        if isEditing {
            
            guard let date = rescueDate else {
                return
            }
            guard let id = litterId else {
                return
            }
//            self.presenter.display(loader: true)
            Task {
                worker.updateLitterDB(litterId: id, rescueDate: date)
            }
            self.presenter.display(loader: false)
        }
        
        if isCreating {
            guard let date = rescueDate else {
                return
            }
//            self.presenter.display(loader: true)
            Task {
                worker.createNewLitter(rescueDate: date)
            }
            self.presenter.display(loader: false)
        }
    }
    
}
