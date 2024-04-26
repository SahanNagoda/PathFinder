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
    
    private let realm: Realm
    
    private init() {
        // Initialize Realm
        realm = try! Realm()
    }
    
    // MARK: - CRUD Operations
    
    func addObject<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print("Error adding object to Realm: \(error)")
        }
    }
    
    func deleteObject<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print("Error deleting object from Realm: \(error)")
        }
    }
    
    func getAllObjects<T: Object>(_ objectType: T.Type) -> Results<T>? {
        return realm.objects(objectType)
    }
}


extension RealmManager {
    func saveGameState(state: GameState){
        addObject(state)
    }
}
