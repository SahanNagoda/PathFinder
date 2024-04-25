//
//  GameViewDataSource.swift
//  PathFinder
//
//  Created by Sahan Nagodavithana on 4/25/24.
//

import UIKit

class GameViewDataSource: NSObject {
    
    // First Count is no of Columns and other one is rows
    var gameBoard: [[Bool]] = []
    var gameState: GameState = GameState(
        robotPosition: GamePosition(row: 0, column: 0),
        flagPosition: GamePosition(row: 4, column: 3))
    
    func reloadGrid(collectionView: UICollectionView) {
        collectionView.reloadData()
        collectionView.scrollToItem(at: gameState.robotPosition.convertToIndexPath(), at: .centeredVertically, animated: true)
    }
    
    
}

// MARK: Custom Methods
extension GameViewDataSource {
    func checkThePositionsEqual(position: GamePosition, indexPath: IndexPath) -> Bool{
        let row = position.row == indexPath.section
        let column = position.column == indexPath.row
        return row && column
    }
    
    func isMoveable(indexPath: IndexPath) -> Bool {
        let robotPosition = gameState.robotPosition
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
        if checkThePositionsEqual(position: gameState.robotPosition, indexPath: indexPath) {
            cell.setupCell(type: .robot)
        } else if checkThePositionsEqual(position: gameState.flagPosition, indexPath: indexPath) {
            cell.setupCell(type: .flag)
        } else{
            cell.setupCell(type: .empty)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isMoveable(indexPath: indexPath) {
            gameState.robotPosition = GamePosition(row: indexPath.section, column: indexPath.row)
            reloadGrid(collectionView: collectionView)
        }
    }
}

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
