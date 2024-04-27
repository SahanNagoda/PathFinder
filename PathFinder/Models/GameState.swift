//
//  GameState.swift
//  PathFinder
//
//  Created by Sahan Nagodavithana on 4/25/24.
//

import Foundation
import RealmSwift


class GameState: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var robotPosition: GamePosition?
    @Persisted var flagPosition: GamePosition?
    @Persisted var startTime: Date
    @Persisted var endTime: Date?
    @Persisted var stepCount: Int = 0
    @Persisted var gridSize: Int
    
    override init() {
        super.init()
    }
    
    internal init(robotPosition: GamePosition, flagPosition: GamePosition, startTime: Date = Date.now, endTime: Date? = nil, gridSize: Int) {
        super.init()
        self.robotPosition = robotPosition
        self.flagPosition = flagPosition
        self.startTime = startTime
        self.endTime = endTime
        self.gridSize = gridSize
    }
    
    func getRankValue() -> Double {
        return GameCalculations().getRankValue(gameState: self)
    }
}

class GamePosition: Object {
    @Persisted var row: Int
    @Persisted var column: Int
    
    override init() {
        super.init()
    }
    
    internal init(row: Int, column: Int) {
        
        self.row = row
        self.column = column
    }
    
    func convertToIndexPath() -> IndexPath {
        return IndexPath(row: column, section: row)
    }
    
    func checkTheSame(position: GamePosition?) -> Bool{
        guard let position = position else { return false }

        return (self.row == position.row) && (self.column == position.column)
    }
}
