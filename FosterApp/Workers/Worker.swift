//
//  Worker.swift
//  FosterApp
//
//  Created by Elora on 01/03/2023.
//

import Foundation
import CoreDataUtilsKit
import UtilsKit
import UIKit
import FirebaseCore
import FirebaseAuth

struct Worker {
    
    
//    MARK: - User
    
    func createUser(name: String, mail: String, id: String) -> User? {
        let user = User(mail: mail, id: id, name: name)
        guard let dbUser = DB_User.create(user: user) else { return nil }
        return user
    }
    
    func fetchUser(id: String) -> User? {
        guard let DBUser = DB_User.get(with: id) else { return nil }
        return User(from: DBUser)
    }

    // MARK: - Kitten
    func fetchKittenFromId(kittenId: String) -> Kitten? {
        guard let DBKitten = DB_Kitten.get(with: kittenId) else { return nil }
        return Kitten(from: DBKitten)
    }
    
    func fetchAllKittensLitter(litterId: String) -> [Kitten]? {
        let predicate = NSPredicate(format: "r_litter.a_id = %@", litterId)
        let DBKittens = DB_Kitten.getAll(predicate: predicate)
        
        let kittens = DBKittens.compactMap { dbkitten in
            Kitten(from: dbkitten)
        }
        return kittens
    }
    
    func createKitten(kitten: Kitten, litter: Litter) -> Kitten? {
        guard let DBKitten = DB_Kitten.create(kitten: kitten, litter: litter) else {return nil}
        try? CoreDataManager.default.save()
        return Kitten(from: DBKitten)
    }
    
    func updateKittenDB(kitten: Kitten) {
        guard let DBKitten = DB_Kitten.get(with: kitten.id) else {return}
        DBKitten.update(kitten: kitten, litterId: kitten.litterId)
        try? CoreDataManager.default.save()
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
    
    func updateLitterDB(litterId: String, rescueDate: Date) {
        guard let DBlitter = DB_Litter.get(with: litterId) else {
            return
        }
        DBlitter.a_rescueDate = rescueDate
        try? CoreDataManager.default.save()
    }
    
    func createNewLitter(rescueDate: Date, user: User) -> Litter? {
        guard let newLitter = DB_Litter.create(rescueDate: rescueDate, user: user) else {
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
    
    func makeFavorite(litterId: String) {
        let predicate = NSPredicate(format: "a_isOngoing == TRUE")
        let oldFavoriteLitter = DB_Litter.getAll(predicate: predicate)
        
        guard let newFavoriteLitter = DB_Litter.get(with: litterId) else {
            return
        }
        newFavoriteLitter.makeFavorite(oldFavorite: oldFavoriteLitter, newFavorite: newFavoriteLitter)
    }
}
