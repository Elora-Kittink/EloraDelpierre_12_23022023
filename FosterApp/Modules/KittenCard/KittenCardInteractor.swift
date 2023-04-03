//  KittenCardInteractor.swift
//
//  Created by Elora on 24/02/2023.
//

import Foundation
import UIKit

class KittenCardInteractor: Interactor
<
    KittenCardViewModel,
    KittenCardPresenter
> {
    let worker = Worker()
    
    
    //    func displayMode(isEditing: Bool,
    //                     isCreating: Bool,
    //                     isDisplaying: Bool,
    //                     litterId: String?,
    //                     kittenId: String?) {
    //
    //        if isEditing && !isCreating && !isDisplaying {
    //            self.presenter.displayMode(type: KittenCardLayoutStyle.editing)
    //        }
    //        if !isEditing && isCreating && !isDisplaying {
    //            self.presenter.displayMode(type: KittenCardLayoutStyle.creating)
    //        }
    //        if !isEditing && !isCreating && isDisplaying {
    //            self.presenter.displayMode(type: KittenCardLayoutStyle.displaying)
    //        }
    //    }
    
    func composeKitten(litter: Litter,
                       firstName: String?,
                       secondName: String?,
                       birthdate: Date?,
                       sex: String?,
                       color: String?,
                       rescueDate: Date?,
                       comment: String?,
                       isAdopted: Bool,
                       microship: Int?,
                       vaccines: [Vaccine]?,
                       adopters: Adopter?,
                       weightHistory: [Weight]?,
                       isEdited: Bool,
                       kittenId: String?,
                       isAlive: Bool) -> Kitten {
        
        var kitten: Kitten
        
        if isEdited {
            kitten = Kitten(from: kittenId,
                            litter: litter,
                            firstName: firstName,
                            secondName: secondName,
                            birthdate: birthdate,
                            sex: sex,
                            color: color,
                            rescueDate: rescueDate,
                            siblings: litter.kittens?.filter { $0.firstName != firstName },
                            comment: comment,
                            isAdopted: isAdopted,
                            microship: microship,
                            vaccines: vaccines,
                            adopters: adopters,
                            weightHistory: weightHistory,
                            isAlive: isAlive)
        } else {
            kitten = Kitten(from: UUID().uuidString,
                            litter: litter,
                            firstName: firstName,
                            secondName: secondName,
                            birthdate: birthdate,
                            sex: sex,
                            color: color,
                            rescueDate: rescueDate,
                            siblings: litter.kittens?.filter { $0.firstName != firstName },
                            comment: comment,
                            isAdopted: isAdopted,
                            microship: microship,
                            vaccines: vaccines,
                            adopters: adopters,
                            weightHistory: weightHistory,
                            isAlive: isAlive)
        }
        return kitten
    }
    
    func saveKittenInDB(isNewKitten: Bool,
                        kitten: Kitten,
                        litter: Litter) {
        
        if isNewKitten {
            Task {
                guard let newKitten = worker.createKitten(kitten: kitten, litter: litter) else {return}
                self.presenter.display(kitten: newKitten, litter: litter)
                self.presenter.displayMode(type: KittenCardLayoutStyle.displaying)
            }
        } else {
            Task {
                worker.updateKittenDB(kitten: kitten)
                self.presenter.display(kitten: kitten, litter: litter)
                self.presenter.displayMode(type: KittenCardLayoutStyle.displaying)
            }
        }        
    }
    
    func refresh(isEditingMode: Bool,
                 isCreatingMode: Bool,
                 isDisplayingMode: Bool,
                 litter: Litter,
                 kittenId: String?,
                 kitten: Kitten?) {
        
        if isDisplayingMode {
            
            guard let kittenId else {return}
            
            Task {
                guard let kitten = worker.fetchKittenFromId(kittenId: kittenId) else {return}
                self.presenter.displayMode(type: KittenCardLayoutStyle.displaying)
                self.presenter.display(kitten: kitten, litter: litter)
            }
        }
        
        if isEditingMode {
            guard let kitten else {return}
            worker.updateKittenDB(kitten: kitten)
            self.presenter.displayMode(type: KittenCardLayoutStyle.editing)
            self.presenter.display(kitten: kitten, litter: litter)
        }
        
        if isCreatingMode {
            self.presenter.displayMode(type: KittenCardLayoutStyle.creating)
        }
    }
}
