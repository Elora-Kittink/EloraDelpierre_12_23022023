//
//  Worker.swift
//  FosterApp
//
//  Created by Elora on 01/03/2023.
//

import Foundation
import CoreDataUtilsKit

struct Worker {
    
    func fetchFromId(kittenId: String) -> Kitten? {
        guard let DBKitten = DB_Kitten.get(with: kittenId) else {
            return nil
        }
        return Kitten(from: DBKitten)
    }
    
    func fetchLitterFromId(litterId: String) -> Litter? {
        guard let DBLitter = DB_Litter.getAll(with: litterId)
    }
}


func fetchFavorites() -> [Recipe] {
    let predicate = NSPredicate(format: "a_isFavorite == TRUE")
    let fetchRequest = DB_Recipe.getAll(predicate: predicate)
    let favoriteRecipes = fetchRequest.map { recipe in
        Recipe(from: recipe)
    }
    return favoriteRecipes
}
