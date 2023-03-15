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
    
    func archiveLitter(litterId: String) {
        Task {
            worker.archiveLitter(litterId:litterId)
        }
    }
    
    func displayDate(date: Date) {
        self.presenter.displayDate(date: date)
        
    }
    
    func makeFavorite(litterId: String) {
        Task {
            worker.makeFavorite(litterId: litterId)
        }
    }
    
    
    func diplayMode(isEditing: Bool, isCreating: Bool, isDisplaying: Bool, litterId: String?) {
        
        if isEditing && !isCreating && !isDisplaying {
            self.presenter.displayMode(type: LayoutStyle.editing, rescueDate: nil, litterId: litterId)
        }
        if !isEditing && isCreating && !isDisplaying {
            self.presenter.displayMode(type: LayoutStyle.creating, rescueDate: nil, litterId: nil)
        }
        if !isEditing && !isCreating && isDisplaying {
            self.presenter.displayMode(type: LayoutStyle.displaying, rescueDate: nil, litterId: litterId)
        }
    }
    
    
    func refresh(isEditing: Bool, isCreating: Bool, isDisplaying: Bool, litterId: String?, rescueDate: Date?) {
        
        if isDisplaying {
            Task {
                guard let litter = worker.fetchLitterFromId(litterId: litterId ?? "") else {
                    return
                }
                self.presenter.displayMode(type: LayoutStyle.displaying, rescueDate: litter.rescueDate?.toDate(format: "dd/MM/yyyy"), litterId: litterId)
                self.presenter.displayDate(date: litter.rescueDate?.toDate(format: "dd/MM/yyyy"))
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
            Task {
                worker.updateLitterDB(litterId: id, rescueDate: date)
                self.presenter.displayMode(type: LayoutStyle.displaying, rescueDate: date, litterId: id)
            }
            
            self.presenter.display(loader: false)
        }
        
        if isCreating {
            guard let date = rescueDate else {
                return
            }
            
            Task {
                guard let newLitter = worker.createNewLitter(rescueDate: date) else {
                    return
                }
                self.presenter.displayMode(type: LayoutStyle.displaying, rescueDate: date, litterId: newLitter.id)
            }
            
            self.presenter.display(loader: false)
        }
    }
    
}
