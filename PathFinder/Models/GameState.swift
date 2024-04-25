//
//  GameState.swift
//  PathFinder
//
//  Created by Sahan Nagodavithana on 4/25/24.
//

import Foundation

class GameState {
    let robotPosition: GamePosition
    let flagPosition: GamePosition
    
    internal init(robotPosition: GamePosition, flagPosition: GamePosition) {
        self.robotPosition = robotPosition
        self.flagPosition = flagPosition
    }
}

class GamePosition {
    var row: Int
    var column: Int
    
    internal init(row: Int, column: Int) {
        self.row = row
        self.column = column
    }
}
