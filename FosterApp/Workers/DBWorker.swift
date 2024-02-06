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

/// `DBWorker` is responsible for handling database operations.
/// It provides methods to create, fetch, and update entities like users, kittens, litters, and weighings.
struct DBWorker {
	
    // MARK: - User Operations
	
	/// Creates and saves a user in the database.
	/// - Parameters:
	///   - name: Name of the user.
	///   - mail: Email of the user.
	///   - id: Unique identifier of the user.
	/// - Returns: An optional `User` object if creation is successful.
    func createUser(name: String, mail: String, id: String) -> User? {
        let user = User(mail: mail, id: id, name: name)
		
        guard let dbUser = DB_User.create(user: user) else {
            print("👹 Worker fail create DB User")
            return nil }
		
		AnalyticsManager.shared.log(event: .userCreated, 
									with: [
										"id": "\(user.id)",
										"name": "\(user.name)"
									])
        print("💃🏼 Worker succeed create \(String(describing: dbUser.a_id)) user")
        try? CoreDataManager.default.save()
        return User(from: dbUser)
    }
    
	/// Fetches a user from the database using their ID.
	/// - Parameter id: The unique identifier of the user.
	/// - Returns: An optional `User` object if found.
    func fetchUser(id: String) -> User? {
		guard let DBUser = DB_User.get(with: id) else {
			print("👹 Worker fail get DB User")
			return nil
		}
		
			AnalyticsManager.shared.log(event: .userFetched, 
										with: [
											"id": "\(DBUser.a_id ?? "")",
											"name": "\(DBUser.a_name ?? "")"
										])
        print("💃🏼 Worker succeed get \(String(describing: DBUser.a_id)) user")
        return User(from: DBUser)
    }
    
	// MARK: - Kitten Operations
	
	/// Fetches a kitten from the database using its ID.
	/// - Parameter kittenId: The unique identifier of the kitten.
	/// - Returns: An optional `Kitten` object if found.
    func fetchKittenFromId(kittenId: String) -> Kitten? {
		guard let DBKitten = DB_Kitten.get(with: kittenId) else {
			print("👹 Worker fail get DB Kitten")
			return nil
		}
		
		AnalyticsManager.shared.log(event: .kittenFetched, 
									with: [
										"id": "\(DBKitten.a_id ?? "")",
										"name": "\(DBKitten.a_firstName ?? "")"
									]
		)
        print("💃🏼 Worker succeed get \(String(describing: DBKitten.a_id)) kitten")
        return Kitten(from: DBKitten)
    }
	
	/// Fetches all kittens of a litter from the database using the litter ID.
	/// - Parameter litterId: The unique identifier of the litter.
	/// - Returns: An array of `Kitten` objects if found.
    func fetchAllKittensLitter(litterId: String) -> [Kitten]? {
        let predicate = NSPredicate(format: "r_litter.a_id = %@", litterId)
        let DBKittens = DB_Kitten.getAll(predicate: predicate)
        
        let kittens = DBKittens.compactMap { dbkitten in
            Kitten(from: dbkitten)
        }
		
        return kittens
    }
    
	/// Creates and saves a kitten in the database.
	/// - Parameters:
	///   - kitten: The `Kitten` object to be saved.
	///   - litter: The `Litter` to which the kitten belongs.
	/// - Returns: An optional `Kitten` object if creation is successful.
    func createKitten(kitten: Kitten, litter: Litter) -> Kitten? {
		guard let DBKitten = DB_Kitten.create(kitten: kitten, litter: litter) else {
			print("👹 Worker fail create DB Kitten")
			return nil
		}
		
        try? CoreDataManager.default.save()
		AnalyticsManager.shared.log(event: .kittenCreated, 
									with: [
										"id": "\(kitten.id ?? "")",
										"name": "\(kitten.firstName ?? "")"
									])
        print("💃🏼 Worker succeed create \(String(describing: DBKitten.a_id)) kitten")
        return Kitten(from: DBKitten)
    }
    
	/// Updates a kitten's information in the database.
	/// - Parameter kitten: The `Kitten` object with updated information.
    func updateKittenDB(kitten: Kitten) {
        guard let DBKitten = DB_Kitten.get(with: kitten.id) else {
            print("👹 Worker fail get DB Kitten to update")
            return}
		
        DBKitten.update(kitten: kitten, litterId: kitten.litterId)
        print("💃🏼 Worker succeed update \(String(describing: DBKitten.a_id)) kitten to update")
        try? CoreDataManager.default.save()
    }
    
    
    
    
	// MARK: - Litter Operations
	
	/// Fetches a litter from the database using its ID.
	/// - Parameter litterId: The unique identifier of the litter.
	/// - Returns: An optional `Litter` object if found.
    func fetchLitterFromId(litterId: String) -> Litter? {
        guard let DBLitter = DB_Litter.get(with: litterId) else {
            print("👹 Worker fail get DB Litter")
            return nil}
		
		AnalyticsManager.shared.log(event: .litterFetched, 
									with: [
										"id": "\(DBLitter.a_id ?? "")",
										"rescue_date": "\(DBLitter.a_rescueDate ?? Date())"
									])
        print("💃🏼 Worker succeed get \(String(describing: DBLitter.a_id)) litter")
        return Litter(from: DBLitter)
    }
    
	/// Fetches all litters associated with a user from the database.
	/// - Parameter userId: The unique identifier of the user.
	/// - Returns: An array of `Litter` objects if found.
    func fetchAllLitters(userId: String) -> [Litter] {
        let predicate = NSPredicate(format: "r_user.a_id == %@", userId)
        
        let litters = DB_Litter.getAll(predicate: predicate)

        let allLitters = litters.map { litter in
            Litter(from: litter)
        }
        return allLitters
    }
    
	/// Updates a litter in the database.
	/// - Parameters:
	///   - litterId: The unique identifier of the litter to be updated.
	///   - rescueDate: The new rescue date for the litter.
    func updateLitterDB(litterId: String, rescueDate: Date) {
        guard let DBlitter = DB_Litter.get(with: litterId) else {
            print("👹 Worker fail get DB Litter to update")
            return
        }
		
        print("💃🏼 Worker succeed get \(String(describing: DBlitter.a_id)) litter to update")
        DBlitter.a_rescueDate = rescueDate
        try? CoreDataManager.default.save()
    }
    
	/// Creates and saves a new litter in the database.
	/// - Parameters:
	///   - rescueDate: The date of rescue for the new litter.
	///   - user: The `User` associated with the new litter.
	/// - Returns: An optional `Litter` object if creation is successful.
    func createNewLitter(rescueDate: Date, user: User) -> Litter? {
        guard let newLitter = DB_Litter.create(rescueDate: rescueDate, user: user) else {
            print("👹 Worker fail create DB Litter")
            return nil
        }
		
        try? CoreDataManager.default.save()
        print("💃🏼 Worker succeed create \(String(describing: newLitter.a_id)) litter")
        return Litter(from: newLitter)
    }
    
	/// Archives a litter by setting its ongoing status to false.
	/// - Parameter litterId: The unique identifier of the litter to be archived.
    func archiveLitter(litterId: String) {
        guard let DBLitter = DB_Litter.get(with: litterId) else {
            print("👹 Worker fail get DB Litter to archive")
            return
        }
		
        DBLitter.archiveLitter()
        print("💃🏼 Worker succeed get \(String(describing: DBLitter.a_id)) litter to archive")
        try? CoreDataManager.default.save()
    }
    
	/// Marks a litter as favorite and unmarks the previous favorite.
	/// - Parameter litterId: The unique identifier of the litter to be marked as favorite.
    func makeFavorite(litterId: String) {
        let predicate = NSPredicate(format: "a_isOngoing == TRUE")
        let oldFavoriteLitter = DB_Litter.getAll(predicate: predicate)
        
        guard let newFavoriteLitter = DB_Litter.get(with: litterId) else {
            print("👹 Worker fail get DB Litter")
            return
        }
        print("💃🏼 Worker succeed get \(String(describing: newFavoriteLitter.a_id)) litter to make favorite")
        newFavoriteLitter.makeFavorite(oldFavorite: oldFavoriteLitter, newFavorite: newFavoriteLitter)
    }
	
	// MARK: - Weighing Operations
	
	/// Fetches all weighings associated with a kitten from the database.
	/// - Parameter kittenId: The unique identifier of the kitten.
	/// - Returns: An array of `Weighing` objects.
	func fetchWeighingFromKittenId(kittenId: String) -> [Weighing]? {
		let predicate = NSPredicate(format: "r_kitten.a_id == %@", kittenId)
		let DBweighings = DB_Weighing.getAll(predicate: predicate)
		
		let allWeighings = DBweighings.map { weighing in
			Weighing(from: weighing)
		}
		
		return allWeighings
	}
	
	/// Creates and saves a new weighing for a kitten in the database.
	/// - Parameters:
	///   - kitten: The `Kitten` associated with the new weighing.
	///   - weighing: The `Weighing` object to be saved.
	/// - Returns: An optional `Weighing` object if creation is successful.
	func createWeighing(kitten: Kitten, weighing: Weighing) -> Weighing? {
		guard let DBWeighing = DB_Weighing.create(weighing: weighing, kitten: kitten) else {
			print("👹 Worker fail create DB Weighing")
			return nil}
		
		try? CoreDataManager.default.save()
		AnalyticsManager.shared.log(event: .weighingCreated, 
									with: [
										"id": "\(DBWeighing.a_id ?? "")",
										"kitten_name": "\(kitten.firstName ?? "")"
									])
		print("💃🏼 Worker succeed create new weighing for \(String(describing: kitten.firstName))")
		return Weighing(from: DBWeighing)
	}
	
	/// Updates a weighing in the database.
	/// - Parameter weighing: The `Weighing` object with updated information.
	func updateWeighing(weighing: Weighing) {
        guard let DBWeighing = DB_Weighing.get(with: weighing.id) else {
            print("👹 Worker fail update DBWeighing")
            return
        }
        
        DBWeighing.update(weighing: weighing)
        print("💃🏼 Worker succeed update DBWeighing")
        try? CoreDataManager.default.save()
	}
}
