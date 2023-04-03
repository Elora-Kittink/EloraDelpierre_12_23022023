//  KittenCardModalInteractor.swift
//
//  Created by Elora on 03/04/2023.
//

import Foundation

class KittenCardModalInteractor: Interactor
<
	KittenCardModalViewModel,
	KittenCardModalPresenter
> {
    
    let worker = Worker()
    
    func refresh(isEdititngMode: Bool, isCreatingMode: Bool, kitten: Kitten) {
        
        if isEdititngMode {
            self.presenter.display(kitten: kitten)
        }
        if isEdititngMode {
            self.presenter.display(kitten: nil)
        }
    }
    
    
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
                       weightHistory: [Weight]?, isEdited: Bool, kittenId: String?, isAlive: Bool) -> Kitten  {
        
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
                            siblings: litter.kittens?.filter {
                $0.firstName != firstName },
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
                            siblings: litter.kittens?.filter {
                $0.firstName != firstName },
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
}
