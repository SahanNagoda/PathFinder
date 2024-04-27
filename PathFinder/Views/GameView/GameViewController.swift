//
//  GameViewController.swift
//  PathFinder
//
//  Created by Sahan Nagodavithana on 4/25/24.
//

import UIKit
import Lottie

class GameViewController: BaseViewController {
    
    // First Count is no of Columns and other one is rows
    private var gameBoard = [[Bool]](repeating: [Bool](repeating: false, count: 6), count: 6)
    private var gameState = GameState(
        robotPosition: GamePosition(row: 0, column: 0),
        flagPosition: GamePosition(row: 4, column: 3), 
        gridSize: 0)
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var dataSource: GameViewDataSource!
    @IBOutlet weak var lottieView: LottieAnimationView!
    
    
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
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        configureDataSource()
        
        reloadTheBoard()
    }
    
    func setupState(state: GameState, rows: Int, columns: Int){
        self.gameState = state
        self.gameBoard = [[Bool]](repeating: [Bool](repeating: false, count: columns), count: rows)
    }
    
    func reloadTheBoard(){
        dataSource.reloadGrid(collectionView: collectionView)
    }
    
    fileprivate func configureDataSource() {
        dataSource.gameBoard = gameBoard
        dataSource.gameState = gameState
        
        dataSource.onGameCompletion = {
            self.onFinishTheGame()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1 ){
                guard let vc = AppStoryboards.mainStoryboard()
                    .instantiateViewController(identifier: "LeaderBoardViewController") as? LeaderBoardViewController else { return }
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    fileprivate func onFinishTheGame() {
        DispatchQueue.main.async {
            self.collectionView.isHidden = true
            self.lottieView.play()
        }
    }
}

//MARK: IBActions
extension GameViewController {
    @IBAction func downButtonPressed(_ sender: Any) {
        guard let robotPosition = gameState.robotPosition else { return }
        if robotPosition.row < (gameBoard.count - 1) {
            robotPosition.row += 1
            gameState.stepCount += 1
            reloadTheBoard()
        }
    }
    
    @IBAction func upButtonPressed(_ sender: Any) {
        guard let robotPosition = gameState.robotPosition else { return }
        if robotPosition.row > 0 {
            robotPosition.row -= 1
            gameState.stepCount += 1
            reloadTheBoard()
        }
    }
    
    @IBAction func leftButtonPressed(_ sender: Any) {
        guard let robotPosition = gameState.robotPosition else { return }
        if robotPosition.column > 0 {
            robotPosition.column -= 1
            gameState.stepCount += 1
            reloadTheBoard()
        }
    }
    
    @IBAction func rightButtonPressed(_ sender: Any) {
        guard let robotPosition = gameState.robotPosition else { return }
        if robotPosition.column < (gameBoard[0].count - 1) {
            robotPosition.column += 1
            gameState.stepCount += 1
            reloadTheBoard()
        }
    }
}
