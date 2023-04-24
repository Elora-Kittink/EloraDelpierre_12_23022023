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
    
    
    // MARK: - User
    
    func createUser(name: String, mail: String, id: String) -> User? {
        let user = User(mail: mail, id: id, name: name)
        guard let dbUser = DB_User.create(user: user) else {
            print("👹 Worker fail create DB User")
            return nil }
        print("💃🏼 Worker succeed create \(dbUser.a_id) user")
        return user
    }
    
    func fetchUser(id: String) -> User? {
        guard let DBUser = DB_User.get(with: id) else {
            print("👹 Worker fail get DB User")
            return nil }
        print("💃🏼 Worker succeed get \(DBUser.a_id) user")
        return User(from: DBUser)
    }
    
    // MARK: - Kitten
    func fetchKittenFromId(kittenId: String) -> Kitten? {
        guard let DBKitten = DB_Kitten.get(with: kittenId) else {
            print("👹 Worker fail get DB Kitten")
            return nil }
        print("💃🏼 Worker succeed get \(DBKitten.a_id) kitten")
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
        guard let DBKitten = DB_Kitten.create(kitten: kitten, litter: litter) else {
            print("👹 Worker fail create DB Kitten")
            return nil}
        try? CoreDataManager.default.save()
        print("💃🏼 Worker succeed create \(DBKitten.a_id) kitten")
        return Kitten(from: DBKitten)
    }
    
    func updateKittenDB(kitten: Kitten) {
        guard let DBKitten = DB_Kitten.get(with: kitten.id) else {
            print("👹 Worker fail get DB Kitten")
            return}
        DBKitten.update(kitten: kitten, litterId: kitten.litterId)
        print("💃🏼 Worker succeed update \(DBKitten.a_id) kitten to update")
        try? CoreDataManager.default.save()
    }
    
    
    
    
    // MARK: - Litter
    
    func fetchLitterFromId(litterId: String) -> Litter? {
        guard let DBLitter = DB_Litter.get(with: litterId) else {
            print("👹 Worker fail get DB Litter")
            return nil}
        print("💃🏼 Worker succeed get \(DBLitter.a_id) litter")
        return Litter(from: DBLitter)
    }
    
    func fetchAllLitters(userId: String) -> [Litter] {
        
        let predicate = NSPredicate(format: "r_user == \(userId)")
        
        let litters = DB_Litter.getAll()
        
        let allLitters = litters.map { litter in
            Litter(from: litter)
        }
        return allLitters
    }
    
    func updateLitterDB(litterId: String, rescueDate: Date) {
        guard let DBlitter = DB_Litter.get(with: litterId) else {
            print("👹 Worker fail get DB Litter")
            return
        }
        print("💃🏼 Worker succeed get \(DBlitter.a_id) litter to update")
        DBlitter.a_rescueDate = rescueDate
        try? CoreDataManager.default.save()
    }
    
    func createNewLitter(rescueDate: Date, user: User) -> Litter? {
        guard let newLitter = DB_Litter.create(rescueDate: rescueDate, user: user) else {
            print("👹 Worker fail create DB Litter")
            return nil
        }
        try? CoreDataManager.default.save()
        print("💃🏼 Worker succeed create \(newLitter.a_id) litter")
        return Litter(from: newLitter)
    }
    
    func archiveLitter(litterId: String) {
        guard let DBLitter = DB_Litter.get(with: litterId) else {
            print("👹 Worker fail get DB Litter")
            return
        }
        DBLitter.archiveLitter()
        print("💃🏼 Worker succeed get \(DBLitter.a_id) litter to archive")
        try? CoreDataManager.default.save()
    }
    
    func makeFavorite(litterId: String) {
        let predicate = NSPredicate(format: "a_isOngoing == TRUE")
        let oldFavoriteLitter = DB_Litter.getAll(predicate: predicate)
        
        guard let newFavoriteLitter = DB_Litter.get(with: litterId) else {
            print("👹 Worker fail get DB Litter")
            return
        }
        print("💃🏼 Worker succeed get \(newFavoriteLitter.a_id) litter to make favorite")
        newFavoriteLitter.makeFavorite(oldFavorite: oldFavoriteLitter, newFavorite: newFavoriteLitter)
    }
}
