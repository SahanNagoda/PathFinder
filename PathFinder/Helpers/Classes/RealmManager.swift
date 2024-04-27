//
//  RealmManager.swift
//  PathFinder
//
//  Created by Sahan Nagodavithana on 4/26/24.
//

import Foundation
import RealmSwift

class RealmManager {
    static let shared = RealmManager()

    
    // MARK: - CRUD Operations
    
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
    
    
    func getAllObjects<T: Object>(_ objectType: T.Type) -> Results<T>? {
        let realm = try! Realm()
        return realm.objects(objectType)
    }
}


extension RealmManager {
    func saveGameState(state: GameState){
        addObject(state)
    }
    
    func getGamesHistory() -> [GameState] {
        return getAllObjects(GameState.self)?.toArray() ?? []
    }
    
    func getLeaderBoard() -> [GameState] {
        var history = getGamesHistory()
        return GameCalculations().rankGameHistory(history: history)
    }
}


