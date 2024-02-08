//  LitterInteractor.swift
//
//  Created by Elora on 24/02/2023.
//

import Foundation
import UIKit
import UtilsKit
import FirebaseCore
import FirebaseAuth

/// `LitterInteractor` handles the business logic for the `LitterViewController`.
class LitterInteractor: Interactor
<
    LitterViewModel,
    LitterPresenter
> {
    
    let worker = DBWorker()
    
	/// Archives a specific litter.
	/// - Parameter litterId: The identifier of the litter to be archived.
	func archiveLitter(litterId: String) {
		worker.archiveLitter(litterId: litterId)
		self.presenter.display(loader: false)
	}

	/// Marks a specific litter as favorite.
	/// - Parameter litterId: The identifier of the litter to be marked as favorite.
	func makeFavorite(litterId: String) {
		worker.makeFavorite(litterId: litterId)
		self.presenter.display(loader: false)
	}
    
	/// Handles the display mode of the litter screen.
	/// - Parameters:
	///   - isEditing: A Boolean value indicating if the screen is in editing mode.
	///   - isCreating: A Boolean value indicating if the screen is in creating mode.
	///   - isDisplaying: A Boolean value indicating if the screen is in displaying mode.
	///   - litterId: The identifier of the litter, if available.
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
    
	/// Saves the litter with the given details.
	/// - Parameters:
	///   - user: The `User` associated with the litter.
	///   - rescueDate: The rescue date of the litter.
	///   - isEditing: A Boolean value indicating if the litter is being edited.
	///   - litterId: The identifier of the litter, if available.
	func saveLitter(rescueDate: Date?, isEditing: Bool, litterId: String?) {
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
			
			let newLitter = worker.createNewLitter(rescueDate: rescueDate)
			self.presenter.display(loader: false)
			self.refresh(litterId: newLitter?.id)
		}
	}
	
	/// Refreshes the litter information.
	/// - Parameter litterId: The identifier of the litter to be refreshed.
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
