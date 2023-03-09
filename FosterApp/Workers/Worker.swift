//
//  Worker.swift
//  FosterApp
//
//  Created by Elora on 01/03/2023.
//

import Foundation
import CoreDataUtilsKit

struct Worker {
    
    
    // MARK: - Kitten
    func fetchKittenFromId(kittenId: String) -> Kitten? {
        guard let DBKitten = DB_Kitten.get(with: kittenId) else { return nil }
        return Kitten(from: DBKitten)
    }
    
    func updateKittenDB(kitten: Kitten) {
//        si le chaton existe déjà on veut une mise à jour
        if let kitten = DB_Kitten.get(with: kitten.id) {
            
        }
//        sinon on veut le créer
    }
    

    
    // MARK: - Litter
    
    func fetchLitterFromId(litterId: String) -> Litter? {
        guard let DBLitter = DB_Litter.get(with: litterId) else { return nil}
        return Litter(from: DBLitter)
    }
    
    func fetchAllLitters() -> [Litter] {
        let predicate = NSPredicate(format: "entityName == DB_Litter")
        let fetchedLitters = DB_Litter.getAll(predicate: predicate)
        let allLitters = fetchedLitters.map { litter in
            Litter(from: litter)
        }
        return allLitters
    }
    
    func updateLitterDB(litter: Litter){
//        si la portée existe déjà on veut une mise à jour
        if let DBlitter = DB_Litter.get(with: litter.id) {
            DBlitter.update(litter: litter)
        }
        else {
//       si elle n'existe pas on la créé
            let DBLitter = DB_Litter()
            DBLitter.create(litter: litter)
        }
    }
    
    func archiveLitter(litterId: String) {
        guard let DBLitter = DB_Litter.get(with: litterId) else {
            return
        }
        DBLitter.archiveLitter()
        try? CoreDataManager.default.save()
    }
}
