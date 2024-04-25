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
    
    internal init(robotPosition: GamePosition, flagPosition: GamePosition) {
        self.robotPosition = robotPosition
        self.flagPosition = flagPosition
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
