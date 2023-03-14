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
//        if let kitten = DB_Kitten.get(with: kitten.id) {
            
//        }
        //        sinon on veut le créer
    }
    
    
    
    // MARK: - Litter
    
    func fetchLitterFromId(litterId: String) -> Litter? {
        guard let DBLitter = DB_Litter.get(with: litterId) else { return nil}
        return Litter(from: DBLitter)
    }
    
    func fetchAllLitters() -> [Litter] {
        let litters = DB_Litter.getAll()
        
        let allLitters = litters.map { litter in
            Litter(from: litter)
        }
        return allLitters
    }
    
    func updateLitterDB(litterId: String, rescueDate: String) {
        guard let DBlitter = DB_Litter.get(with: litterId) else {
            return
        }
        DBlitter.a_rescueDate = rescueDate
        try? CoreDataManager.default.save()
    }
    
    func createNewLitter(rescueDate: String) -> Litter? {
        guard let newLitter = DB_Litter.create(rescueDate: rescueDate) else {
            print("pas réussi à créer la portée")
            return nil
        }
        try? CoreDataManager.default.save()
        return Litter(from: newLitter)
    }
    
    func archiveLitter(litterId: String) {
        guard let DBLitter = DB_Litter.get(with: litterId) else {
            return
        }
        DBLitter.archiveLitter()
        try? CoreDataManager.default.save()
    }
}
