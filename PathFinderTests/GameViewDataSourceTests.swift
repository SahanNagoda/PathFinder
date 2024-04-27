//
//  GameViewDataSourceTests.swift
//  PathFinderTests
//
//  Created by Sahan Nagodavithana on 4/28/24.
//

import XCTest
@testable import PathFinder

class GameViewDataSourceTests: XCTestCase {

    var dataSource: GameViewDataSource!

    override func setUp() {
        super.setUp()
        dataSource = GameViewDataSource()
    }

    override func tearDown() {
        dataSource = nil
        super.tearDown()
    }

    func testCheckThePositionsEqual() {
        // Given
        let position = GamePosition(row: 2, column: 3)
        let indexPath = IndexPath(row: 3, section: 2)

        // When & Then
        XCTAssertTrue(dataSource.checkThePositionsEqual(position: position, indexPath: indexPath)) // Check if the positions are equal
    }

    func testIsMoveable() {
        // Given
        let robotPosition = GamePosition(row: 2, column: 3)
        let indexPath1 = IndexPath(row: 3, section: 2) // Same position as robot
        let indexPath2 = IndexPath(row: 3, section: 3) // One row below robot
        let indexPath3 = IndexPath(row: 4, section: 2) // One column right to robot
        let indexPath4 = IndexPath(row: 4, section: 4) // Diagonal position

        // When & Then
        XCTAssertFalse(dataSource.isMoveable(robotPosition: robotPosition, indexPath: indexPath1)) // Robot cannot move to the same position
        XCTAssertTrue(dataSource.isMoveable(robotPosition: robotPosition, indexPath: indexPath2)) // Robot can move one row below
        XCTAssertTrue(dataSource.isMoveable(robotPosition: robotPosition, indexPath: indexPath3)) // Robot can move one column right
        XCTAssertFalse(dataSource.isMoveable(robotPosition: robotPosition, indexPath: indexPath4)) // Robot cannot move diagonally
    }
}
