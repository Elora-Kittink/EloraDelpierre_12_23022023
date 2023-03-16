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
    
    func displayDate(date: Date,
                     sender: UITextField) {
        self.presenter.displayDate(date: date, textField: sender)
        
    }
    
//    func refresh(newKittenCreation: Bool,
//                 kittenId: String,
//                 litterId: String) {
//
//    }
    
    func displayMode(isEditing: Bool,
                     isCreating: Bool,
                     isDisplaying: Bool,
                     litterId: String?,
                     kittenId: String?) {
        
        if isEditing && !isCreating && !isDisplaying {
            self.presenter.displayMode(type: KittenCardLayoutStyle.editing)
        }
        if !isEditing && isCreating && !isDisplaying {
            self.presenter.displayMode(type: KittenCardLayoutStyle.creating)
        }
        if !isEditing && !isCreating && isDisplaying {
            self.presenter.displayMode(type: KittenCardLayoutStyle.displaying)
        }
    }
    
    func createKitten(litter: Litter,
                      firstName: String,
                      secondName: String?,
                      birthdate: Date?,
                      sex: String?,
                      color: String?,
                      rescueDate: Date,
                      comment: String?,
                      isAdopted: Bool,
                      microship: Int?,
                      vaccines: [Vaccine]?,
                      adopters: Adopter?,
                      weightHistory: [Weight]?) -> Kitten  {
        
        let kitten = Kitten(from: UUID().uuidString,
                            litter: litter,
                            firstName: firstName,
                            secondName: secondName,
                            birthdate: birthdate,
                            sex: sex,
                            color: color,
                            rescueDate: rescueDate,
                            siblings: litter.kittens?.filter {
                        $0.firstName != firstName },
                            comment: comment,
                            isAdopted: isAdopted,
                            microship: microship,
                            vaccines: vaccines,
                            adopters: adopters,
                            weightHistory: weightHistory,
                            isAlive: true)
        
        Task {
            guard let newKitten = worker.createKitten(kitten: kitten) else {return}
            self.presenter.display(kitten: newKitten)
            self.presenter.displayMode(type: KittenCardLayoutStyle.displaying)
        }

        
        return kitten
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
                self.presenter.display(kitten: kitten)
            }
        }
        if isEditingMode {
            
        }
        
        if isCreatingMode {
            
            
        }
    }
}
