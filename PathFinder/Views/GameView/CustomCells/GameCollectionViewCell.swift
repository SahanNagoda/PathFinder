//
//  GameCollectionViewCell.swift
//  PathFinder
//
//  Created by Sahan Nagodavithana on 4/25/24.
//

import UIKit

enum GameCellType {
    case flag
    case robot
    case empty
}

class GameCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var typeImageView: UIImageView!
    
    class func cellIdentifier() -> String {
        return "GameCollectionViewCell"
    }
}

// MARK: Custom Methods
extension GameCollectionViewCell {
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
