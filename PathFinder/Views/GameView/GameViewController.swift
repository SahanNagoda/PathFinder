//
//  GameViewController.swift
//  PathFinder
//
//  Created by Sahan Nagodavithana on 4/25/24.
//

import UIKit

class GameViewController: BaseViewController {
    
    // First Count is no of Columns and other one is rows
    var gameBoard = [[Bool]](repeating: [Bool](repeating: false, count: 6), count: 6)
    var gameState = GameState(
        robotPosition: GamePosition(row: 0, column: 0),
        flagPosition: GamePosition(row: 4, column: 3))
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var dataSource: GameViewDataSource!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
}

// MARK: Custom Methods
extension GameViewController {
    func configure() {
        baseNavigationBarConfigurations()
        showNavigationBar()
        title = "Pronto - Path Finder"
        
        dataSource.gameBoard = gameBoard
        dataSource.gameState = gameState
        
        dataSource.onGameCompletion = {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 2, animations: {
                    self.collectionView.alpha = 0
                }) { (finished) in
                    self.collectionView.isHidden = finished
                }
            }
            
        }
        
        reloadTheBoard()
    }
    
    func reloadTheBoard(){
        dataSource.reloadGrid(collectionView: collectionView)
    }
}

//MARK: IBActions
extension GameViewController {
    @IBAction func downButtonPressed(_ sender: Any) {
        let robotPosition = gameState.robotPosition
        if robotPosition.row < (gameBoard.count - 1) {
            robotPosition.row += 1
            reloadTheBoard()
        }
    }
    
    @IBAction func upButtonPressed(_ sender: Any) {
        let robotPosition = gameState.robotPosition
        if robotPosition.row > 0 {
            robotPosition.row -= 1
            reloadTheBoard()
        }
    }
    
    @IBAction func leftButtonPressed(_ sender: Any) {
        let robotPosition = gameState.robotPosition
        if robotPosition.column > 0 {
            robotPosition.column -= 1
            reloadTheBoard()
        }
    }
    
    @IBAction func rightButtonPressed(_ sender: Any) {
        let robotPosition = gameState.robotPosition
        if robotPosition.column < (gameBoard[0].count - 1) {
            robotPosition.column += 1
            reloadTheBoard()
        }
    }
}
