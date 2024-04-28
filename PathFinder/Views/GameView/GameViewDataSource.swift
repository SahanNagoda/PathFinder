//
//  GameViewDataSource.swift
//  PathFinder
//
//  Created by Sahan Nagodavithana on 4/25/24.
//

import UIKit
import RealmSwift

/// DataSource class responsible for managing the game grid and interactions with the UICollectionView.
class GameViewDataSource: NSObject {
    
    /// Represents the game board grid, where each element indicates whether a cell is occupied.
    var gameBoard: [[Bool]] = []
    
    /// Represents the current state of the game.
    var gameState: GameState = GameState(
        robotPosition: GamePosition(row: 0, column: 0),
        flagPosition: GamePosition(row: 4, column: 3),
        gridSize: 0)
    
    /// Closure called when the game is completed.
    var onGameCompletion: (() -> Void)?
    
    /// Reloads the UICollectionView associated with the game grid.
    ///
    /// - Parameter collectionView: The UICollectionView to reload.
    func reloadGrid(collectionView: UICollectionView) {
        collectionView.reloadData()
        
        // Scroll to the current robot position.
        if let robotPosition = gameState.robotPosition {
            collectionView.scrollToItem(at: robotPosition.convertToIndexPath(), at: .centeredVertically, animated: true)
        }
        
        // Check if the robot has reached the flag position to complete the game.
        if gameState.robotPosition?.checkTheSame(position: gameState.flagPosition)  == true {
            gameState.endTime = Date.now
            onGameCompletion?()
            
            // Save the game state to the database asynchronously.
            DispatchQueue.main.async {
                RealmManager.shared.saveGameState(state: self.gameState)
            }
        }
    }
}

// MARK: - Custom Methods
extension GameViewDataSource {
    
    /// Checks if the given position and index path represent the same cell in the grid.
    ///
    /// - Parameters:
    ///   - position: The position to compare.
    ///   - indexPath: The index path to compare.
    /// - Returns: `true` if the positions are equal, otherwise `false`.
    func checkThePositionsEqual(position: GamePosition, indexPath: IndexPath) -> Bool{
        let row = position.row == indexPath.section
        let column = position.column == indexPath.row
        return row && column
    }
    
    /// Determines if the robot can move to the specified index path.
    ///
    /// - Parameters:
    ///   - robotPosition: The current position of the robot.
    ///   - indexPath: The index path to move to.
    /// - Returns: `true` if the robot can move, otherwise `false`.
    func isMoveable(robotPosition: GamePosition, indexPath: IndexPath) -> Bool {
        let robotIndexPath = robotPosition.convertToIndexPath()
        
        if robotIndexPath == indexPath {
            return false
        } else if robotIndexPath.row == indexPath.row {
            let difference = robotIndexPath.section - indexPath.section
            return abs(difference) == 1
        } else if robotIndexPath.section == indexPath.section {
            let difference = robotIndexPath.row - indexPath.row
            return abs(difference) == 1
        }
        
        return false
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension GameViewDataSource: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return gameBoard.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameBoard[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: GameCollectionViewCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: GameCollectionViewCell.cellIdentifier(), for: indexPath
        ) as? GameCollectionViewCell else { return UICollectionViewCell()}
        
        guard let robotPosition = gameState.robotPosition, let flagPosition = gameState.flagPosition else { return cell }
        
        if checkThePositionsEqual(position: robotPosition, indexPath: indexPath) {
            cell.setupCell(type: .robot)
        } else if checkThePositionsEqual(position:flagPosition, indexPath: indexPath) {
            cell.setupCell(type: .flag)
        } else{
            cell.setupCell(type: .empty)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let robotPosition = gameState.robotPosition else { return }
        if isMoveable(robotPosition: robotPosition, indexPath: indexPath) {
            gameState.robotPosition = GamePosition(row: indexPath.section, column: indexPath.row)
            gameState.stepCount += 1
            reloadGrid(collectionView: collectionView)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension GameViewDataSource: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize: CGRect = UIScreen.main.bounds
        let columnCount = gameBoard[indexPath.section].count
        let collectionViewPadding: CGFloat = 16 * 2
        let cellPaddings: CGFloat = CGFloat((columnCount - 1) * 0)
        let paddings = cellPaddings + collectionViewPadding
        let cellSize = (screenSize.width - paddings) / CGFloat(columnCount)
        
        return CGSize(width: cellSize, height: cellSize)
    }
}
