//
//  RealmManager.swift
//  PathFinder
//
//  Created by Sahan Nagodavithana on 4/26/24.
//

import Foundation
import RealmSwift

/// Class responsible for managing interactions with the Realm database.
class RealmManager {
    /// Shared instance of the RealmManager.
    static let shared = RealmManager()
    
    // MARK: - CRUD Operations
    
    /// Adds an object to the Realm database.
    ///
    /// - Parameter object: The object to be added to the database.
    func addObject<T: Object>(_ object: T) {
        let realm = try! Realm()
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print("Error adding object to Realm: \(error)")
        }
    }
    
    /// Retrieves all objects of a specific type from the Realm database.
    ///
    /// - Parameter objectType: The type of objects to retrieve.
    /// - Returns: A `Results` object containing the retrieved objects.
    func getAllObjects<T: Object>(_ objectType: T.Type) -> Results<T>? {
        let realm = try! Realm()
        return realm.objects(objectType)
    }
}

extension RealmManager {
    /// Saves a game state object to the Realm database.
    ///
    /// - Parameter state: The game state object to be saved.
    func saveGameState(state: GameState){
        addObject(state)
    }
    
    /// Retrieves the game history from the Realm database.
    ///
    /// - Returns: An array containing the game states representing the game history.
    func getGamesHistory() -> [GameState] {
        return getAllObjects(GameState.self)?.toArray() ?? []
    }
    
    /// Retrieves the leaderboard from the Realm database.
    ///
    /// - Returns: An array containing the game states representing the leaderboard.
    func getLeaderBoard() -> [GameState] {
        let history = getGamesHistory()
        return GameCalculations().rankGameHistory(history: history)
    }
}
