//  KittenCardInteractor.swift
//
//  Created by Elora on 24/02/2023.
//

class KittenCardInteractor: Interactor
<
	KittenCardViewModel,
	KittenCardPresenter
> {
    
    func refresh(newKittenCreation: Bool, kittenId: String) {
        if newKittenCreation {
//            afficher une fiche chaton vierge à remplir
        } else {
//            chercher le chaton dans la base de données
        }
    }
}
