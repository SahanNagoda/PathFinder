//
//  GameCollectionViewCell.swift
//  PathFinder
//
//  Created by Sahan Nagodavithana on 4/25/24.
//

import UIKit

/// Enum representing the type of cell in the game grid.
enum GameCellType {
    case flag
    case robot
    case empty
}

/// Collection view cell for displaying the game grid.
class GameCollectionViewCell: UICollectionViewCell {
    
    /// Image view displaying the type of cell.
    @IBOutlet weak var typeImageView: UIImageView!
    
    /// Returns the reusable cell identifier.
    ///
    /// - Returns: The reusable cell identifier.
    class func cellIdentifier() -> String {
        return "GameCollectionViewCell"
    }
}

// MARK: - Custom Methods
extension GameCollectionViewCell {
    
    /// Configures the cell with the specified type.
    ///
    /// - Parameter type: The type of cell to display.
    func setupCell(type: GameCellType = .empty){
        typeImageView.isHidden = false
        switch type {
        case .flag:
            backgroundColor = .primaryOrange25
            typeImageView.image = .flag
        case .robot:
            backgroundColor = .primaryOrange25
            typeImageView.image = .pawnBlack
        case .empty:
            backgroundColor = .white
            typeImageView.isHidden = true
        }
    }
}
