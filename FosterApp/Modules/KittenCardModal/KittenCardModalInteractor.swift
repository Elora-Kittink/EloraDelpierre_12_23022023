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
    
    let worker = DBWorker()
    
    func refresh(isEdititngMode: Bool, isCreatingMode: Bool, kitten: Kitten?) {
        
        if isEdititngMode {
            self.presenter.display(kitten: kitten)
        }
        if isCreatingMode {
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
                       weightHistory: [Weight]?,
                       isEdited: Bool,
                       kittenId: String?,
                       isAlive: Bool) -> Kitten {
        
     
     
        let kitten = Kitten(from: isEdited ? kittenId : UUID().uuidString,
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
        
        return kitten
    }
    
   func saveKitten(isNewKitten: Bool,
                   kitten: Kitten,
                   litter: Litter) {
       
       if isNewKitten {
           Task {
               guard let newKitten = worker.createKitten(kitten: kitten, litter: litter) else {return}
               self.presenter.close()
           }
       } else {
           Task {
               worker.updateKittenDB(kitten: kitten)
               self.presenter.display(kitten: kitten)
           }
       }
    }
}
