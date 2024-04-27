//
//  GameCalculationsTests.swift
//  PathFinderTests
//
//  Created by Sahan Nagodavithana on 4/28/24.
//

import XCTest
@testable import PathFinder

class GameCalculationsTests: XCTestCase {

    var gameCalculations: GameCalculations!


    override func setUp() {
        super.setUp()
        gameCalculations = GameCalculations()
    }

    override func tearDown() {
        gameCalculations = nil
        super.tearDown()
    }

    func testRankGameHistory() {
        // Given
        let gameState1 = GameState(robotPosition: GamePosition(row: 1, column: 1), flagPosition: GamePosition(row: 2, column: 2), startTime: Date(), gridSize: 4)
        let gameState2 = GameState(robotPosition: GamePosition(row: 1, column: 2), flagPosition: GamePosition(row: 2, column: 3), startTime: Date(), gridSize: 4)
        let gameState3 = GameState(robotPosition: GamePosition(row: 1, column: 3), flagPosition: GamePosition(row: 2, column: 4), startTime: Date(), gridSize: 4)
        let gameHistory = [gameState1, gameState2, gameState3]

        // When
        let rankedHistory = gameCalculations.rankGameHistory(history: gameHistory)

        // Then
        XCTAssertEqual(rankedHistory.count, 3) // Check if the output count is correct
        XCTAssertEqual(rankedHistory.first?.robotPosition?.column, 3) // Check if the highest column position is first
    }

    func testGetRankValue() {
        // Given
        let startTime = Date()
        let endTime = startTime.addingTimeInterval(60)
        let stepCount = 10
        let gameState = GameState(robotPosition: GamePosition(row: 1, column: 1), flagPosition: GamePosition(row: 2, column: 2), startTime: startTime, endTime: endTime, gridSize: 4)
        gameState.stepCount = stepCount

        // When
        let rankValue = gameState.getRankValue()

        // Then
        XCTAssertEqual(rankValue, 150) // Check if the rank value calculation is correct
    }

    func testGenerateGameState() {
        // When
        let gameState = gameCalculations.generateGameState(row: 5, column: 5)

        // Then
        XCTAssertEqual(gameState.gridSize, 25) // Check if the grid size is correct
        XCTAssertNotNil(gameState.flagPosition) // Check if flag position is not nil
        XCTAssertNotNil(gameState.robotPosition) // Check if robot position is not nil
        XCTAssertFalse(gameState.flagPosition?.checkTheSame(position: gameState.robotPosition) ?? true) // Check if flag and robot positions are different
    }

    func testGetRandomPosition() {
        // When
        let position = gameCalculations.getRandomPosition(row: 5, column: 5)

        // Then
        XCTAssertLessThanOrEqual(position.row, 4) // Check if row is within bounds
        XCTAssertLessThanOrEqual(position.column, 4) // Check if column is within bounds
    }

    func testGetDifferenceFromTwoDates() {
        // Given
        let startTime = Date()
        let endTime = startTime.addingTimeInterval(65) // 1 hour, 1 minute, and 5 seconds

        // When
        let difference = gameCalculations.getDifferenceFromTwoDates(start: startTime, end: endTime)

        // Then
        XCTAssertEqual(difference, "01:05 min") // Check if the difference calculation is correct
    }
}
