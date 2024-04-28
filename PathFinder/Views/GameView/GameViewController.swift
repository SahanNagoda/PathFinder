//
//  GameViewController.swift
//  PathFinder
//
//  Created by Sahan Nagodavithana on 4/25/24.
//

import UIKit
import Lottie

/// View controller responsible for managing the game interface and interactions.
class GameViewController: BaseViewController {
    
    /// Represents the game board grid, where each element indicates whether a cell is occupied.
    private var gameBoard = [[Bool]](repeating: [Bool](repeating: false, count: 6), count: 6)
    
    /// Represents the current state of the game.
    private var gameState = GameState(
        robotPosition: GamePosition(row: 0, column: 0),
        flagPosition: GamePosition(row: 4, column: 3),
        gridSize: 0)
    
    /// The collection view displaying the game grid.
    @IBOutlet weak var collectionView: UICollectionView!
    
    /// The data source object for the collection view.
    @IBOutlet var dataSource: GameViewDataSource!
    
    /// The Lottie animation view for displaying game completion animation.
    @IBOutlet weak var lottieView: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

// MARK: - Custom Methods
extension GameViewController {
    
    /// Configures initial setup of the view controller.
    func configure() {
        baseNavigationBarConfigurations()
        showNavigationBar()
        title = "Pronto - Path Finder"
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        configureDataSource()
        reloadTheBoard()
    }
    
    /// Sets up the initial state of the game.
    ///
    /// - Parameters:
    ///   - state: The initial game state.
    ///   - rows: The number of rows in the game board.
    ///   - columns: The number of columns in the game board.
    func setupState(state: GameState, rows: Int, columns: Int){
        self.gameState = state
        self.gameBoard = [[Bool]](repeating: [Bool](repeating: false, count: columns), count: rows)
    }
    
    /// Reloads the game board grid.
    func reloadTheBoard(){
        dataSource.reloadGrid(collectionView: collectionView)
    }
    
    /// Configures the data source for the collection view.
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
    
    /// Handles actions to perform when the game is completed.
    fileprivate func onFinishTheGame() {
        DispatchQueue.main.async {
            self.collectionView.isHidden = true
            self.lottieView.play()
        }
    }
}

// MARK: - IBActions
extension GameViewController {
    
    /// Handles the action when the down button is pressed.
    @IBAction func downButtonPressed(_ sender: Any) {
        guard let robotPosition = gameState.robotPosition else { return }
        if robotPosition.row < (gameBoard.count - 1) {
            robotPosition.row += 1
            gameState.stepCount += 1
            reloadTheBoard()
        }
    }
    
    /// Handles the action when the up button is pressed.
    @IBAction func upButtonPressed(_ sender: Any) {
        guard let robotPosition = gameState.robotPosition else { return }
        if robotPosition.row > 0 {
            robotPosition.row -= 1
            gameState.stepCount += 1
            reloadTheBoard()
        }
    }
    
    /// Handles the action when the left button is pressed.
    @IBAction func leftButtonPressed(_ sender: Any) {
        guard let robotPosition = gameState.robotPosition else { return }
        if robotPosition.column > 0 {
            robotPosition.column -= 1
            gameState.stepCount += 1
            reloadTheBoard()
        }
    }
    
    /// Handles the action when the right button is pressed.
    @IBAction func rightButtonPressed(_ sender: Any) {
        guard let robotPosition = gameState.robotPosition else { return }
        if robotPosition.column < (gameBoard[0].count - 1) {
            robotPosition.column += 1
            gameState.stepCount += 1
            reloadTheBoard()
        }
    }
}
