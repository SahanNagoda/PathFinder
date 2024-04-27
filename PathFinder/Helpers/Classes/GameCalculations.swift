//
//  GameCalculations.swift
//  PathFinder
//
//  Created by Sahan Nagodavithana on 4/27/24.
//

import Foundation

class GameCalculations {
    func rankGameHistory(history: [GameState]) -> [GameState] {
        var gameHistory = history
        gameHistory.sort(){$0.startTime > $1.startTime}
        var lastFive = Array(gameHistory.prefix(5))
        lastFive.sort(){$0.getRankValue() < $1.getRankValue()}
        return lastFive
    }
    
    func getRankValue(gameState: GameState) -> Double {
        let timeDiff = abs((gameState.endTime?.timeIntervalSince1970 ?? 0) - gameState.startTime.timeIntervalSince1970)
        return Double(gameState.stepCount) * timeDiff / Double(gameState.gridSize)
    }
    
    func generateGameState(row: Int, column: Int) -> GameState{
        let flagPosition = getRandomPosition(row: row, column: column)
        var robotPosition = getRandomPosition(row: row, column: column)
        
        while flagPosition.checkTheSame(position: robotPosition) {
            robotPosition = getRandomPosition(row: row, column: column)
        }
        let state = GameState(robotPosition: robotPosition, flagPosition: flagPosition, gridSize: row * column)
        
        return state
    }
    
    func getRandomPosition(row: Int, column: Int) -> GamePosition{
        let randomRow = Int.random(in: 0..<row)
        let randomColumn = Int.random(in: 0..<column)
        return GamePosition(row: randomRow, column: randomColumn)
    }
    
    
    func getDifferenceFromTwoDates(start: Date, end: Date) -> String {
           let diff = Int(end.timeIntervalSince1970 - start.timeIntervalSince1970)
           let hours = diff / 3600
           let minutes = (diff - hours * 3600) / 60
           let seconds = (diff - hours * 3600 - minutes * 60)
           return String(format: "%02d:%02d min", minutes, seconds)
    }
}
