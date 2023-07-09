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
		worker.archiveLitter(litterId: litterId)
		self.presenter.display(loader: false)
	}
	
	func makeFavorite(litterId: String) {
		worker.makeFavorite(litterId: litterId)
		self.presenter.display(loader: false)
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
		self.presenter.display(loader: false)
    }
    
	func saveLitter(user: User, rescueDate: Date?, isEditing: Bool, litterId: String?) {
		if isEditing {
			guard let rescueDate, let litterId else {
				AlertManager.shared.show(actions: [AlertAction(title: "Erreur", style: .default)], message: "Vous devez saisir une date")
				self.presenter.display(loader: false)
				return
			}
			worker.updateLitterDB(litterId: litterId, rescueDate: rescueDate)
		} else {
			guard let rescueDate else {
				AlertManager.shared.show(actions: [AlertAction(title: "Erreur", style: .default)], message: "Vous devez saisir une date")
				self.presenter.display(loader: false)
				return
			}
			
			worker.createNewLitter(rescueDate: rescueDate, user: user)
			self.presenter.display(loader: false)
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
