//
//  GamePositionTests.swift
//  PathFinderTests
//
//  Created by Sahan Nagodavithana on 4/28/24.
//

import XCTest
@testable import PathFinder

class GamePositionTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testConvertToIndexPath() {
        // Given
        let position = GamePosition(row: 2, column: 3)

        // When
        let indexPath = position.convertToIndexPath()

        // Then
        XCTAssertEqual(indexPath.row, 3) // Check if the row is correctly set
        XCTAssertEqual(indexPath.section, 2) // Check if the section is correctly set
    }

    func testCheckTheSame() {
        // Given
        let position1 = GamePosition(row: 2, column: 3)
        let position2 = GamePosition(row: 2, column: 3)
        let position3 = GamePosition(row: 3, column: 4)

        // When & Then
        XCTAssertTrue(position1.checkTheSame(position: position2)) // Check if two identical positions are the same
        XCTAssertFalse(position1.checkTheSame(position: position3)) // Check if two different positions are not the same
        XCTAssertFalse(position1.checkTheSame(position: nil)) // Check if the position is not the same when comparing with nil
    }
}
