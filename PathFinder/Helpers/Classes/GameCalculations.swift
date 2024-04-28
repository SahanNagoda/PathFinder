//
//  GameCalculations.swift
//  PathFinder
//
//  Created by Sahan Nagodavithana on 4/27/24.
//

import Foundation

/// A utility class providing methods for calculating game-related values and generating game states.
class GameCalculations {
    
    /// Ranks the game history based on game states.
    ///
    /// - Parameter history: An array of game states.
    /// - Returns: An array of the top five game states based on rank.
    func rankGameHistory(history: [GameState]) -> [GameState] {
        var gameHistory = history
        gameHistory.sort(){$0.startTime > $1.startTime}
        var lastFive = Array(gameHistory.prefix(5))
        lastFive.sort(){$0.getRankValue() < $1.getRankValue()}
        return lastFive
    }
    
    /// Calculates the rank value for a given game state.
    ///
    /// - Parameter gameState: The game state for which to calculate the rank value.
    /// - Returns: The rank value of the game state.
    func getRankValue(gameState: GameState) -> Double {
        let timeDiff = abs((gameState.endTime?.timeIntervalSince1970 ?? 0) - gameState.startTime.timeIntervalSince1970)
        return Double(gameState.stepCount) * timeDiff / Double(gameState.gridSize)
    }
    
    /// Generates a new game state with random positions for the robot and flag.
    ///
    /// - Parameters:
    ///   - row: The number of rows in the game grid.
    ///   - column: The number of columns in the game grid.
    /// - Returns: A new game state with randomly generated positions.
    func generateGameState(row: Int, column: Int) -> GameState{
        let flagPosition = getRandomPosition(row: row, column: column)
        var robotPosition = getRandomPosition(row: row, column: column)
        
        while flagPosition.checkTheSame(position: robotPosition) {
            robotPosition = getRandomPosition(row: row, column: column)
        }
        let state = GameState(robotPosition: robotPosition, flagPosition: flagPosition, gridSize: row * column)
        
        return state
    }
    
    /// Generates a random position within the game grid.
    ///
    /// - Parameters:
    ///   - row: The number of rows in the game grid.
    ///   - column: The number of columns in the game grid.
    /// - Returns: A randomly generated position within the grid.
    func getRandomPosition(row: Int, column: Int) -> GamePosition{
        let randomRow = Int.random(in: 0..<row)
        let randomColumn = Int.random(in: 0..<column)
        return GamePosition(row: randomRow, column: randomColumn)
    }
    
    /// Calculates the difference in time between two dates and returns it as a string.
    ///
    /// - Parameters:
    ///   - start: The start date.
    ///   - end: The end date.
    /// - Returns: A string representing the time difference in the format "MM:SS min".
    func getDifferenceFromTwoDates(start: Date, end: Date) -> String {
        let diff = Int(end.timeIntervalSince1970 - start.timeIntervalSince1970)
        let hours = diff / 3600
        let minutes = (diff - hours * 3600) / 60
        let seconds = (diff - hours * 3600 - minutes * 60)
        return String(format: "%02d:%02d min", minutes, seconds)
    }
}
