//
//  GameState.swift
//  PathFinder
//
//  Created by Sahan Nagodavithana on 4/25/24.
//

import Foundation

class GameState {
    var robotPosition: GamePosition
    let flagPosition: GamePosition
    let startTime: Date
    var endTime: Date?
    var stepCount: Int = 0
    
    internal init(robotPosition: GamePosition, flagPosition: GamePosition, startTime: Date = Date.now, endTime: Date? = nil) {
        self.robotPosition = robotPosition
        self.flagPosition = flagPosition
        self.startTime = startTime
        self.endTime = endTime
    }
}

class GamePosition: Equatable {
    var row: Int
    var column: Int
    
    internal init(row: Int, column: Int) {
        self.row = row
        self.column = column
    }
    
    func convertToIndexPath() -> IndexPath {
        return IndexPath(row: column, section: row)
    }
    
    static func == (lhs: GamePosition, rhs: GamePosition) -> Bool {
        return (lhs.row == rhs.row) && (lhs.column == rhs.column)
    }
}
