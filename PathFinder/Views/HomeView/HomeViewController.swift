//
//  HomeViewController.swift
//  PathFinder
//
//  Created by Sahan Nagodavithana on 4/26/24.
//

import UIKit

/// View controller responsible for managing the home screen of the application.
class HomeViewController: BaseViewController {
    
    /// Container view for the guess grid.
    @IBOutlet weak var guessGridContainerView: UIView!
    
    /// Container view for the generated grid.
    @IBOutlet weak var generatedGridContainerView: UIView!
    
    /// View controller managing the guess grid.
    var guessGridVC: GuessGridContainerVC?
    
    /// View controller managing the generated grid.
    var generateGridVC: GenerateGridVC?
    
    /// The number of rows in the game grid.
    var rowCount: Int = 4
    
    /// The number of columns in the game grid.
    var columnCount: Int = 5
    
    /// The current state of the game.
    var gameState: GameState?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configure()
    }
}

// MARK: - Custom Methods
extension HomeViewController {
    
    /// Configures the initial setup of the view controller.
    func configure() {
        baseNavigationBarConfigurations()
        showNavigationBar()
        title = "Pronto - Path Finder"
        
        generatedGridContainerView.isHidden = false
        guessGridContainerView.isHidden = true
    }
    
    /// Generates a new game grid with random dimensions.
    func generateGrid(){
        let randomRow = Int.random(in: 4...6)
        let randomColumn = Int.random(in: 4...6)
        
        self.rowCount = randomRow
        self.columnCount = randomColumn
        
        self.guessGridVC?.setupGrid(row: randomRow, column: randomColumn)
        
        self.gameState = GameCalculations().generateGameState(row: randomRow, column: randomColumn)
    }
}

//MARK: - Segue
extension HomeViewController {
    
    /// Prepares for navigation to other view controllers based on segues.
    ///
    /// - Parameters:
    ///   - segue: The segue that triggered the transition.
    ///   - sender: The object that initiated the segue.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GuessGridSegue" {
            if (segue.destination .isKind(of: GuessGridContainerVC.self)) {
                guard let segueContainer = segue.destination as?  GuessGridContainerVC else { return }
                guessGridVC = segueContainer
                guessGridVC?.onCompletion = {
                    guard let vc = AppStoryboards.mainStoryboard()
                        .instantiateViewController(identifier: "GameViewController") as? GameViewController else { return }
                    if let gameState = self.gameState {
                        vc.setupState(state: gameState, rows: self.rowCount, columns: self.columnCount)
                    }
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        } else if segue.identifier == "GenerateGridSegue" {
            if (segue.destination .isKind(of: GenerateGridVC.self)) {
                guard let segueContainer = segue.destination as?  GenerateGridVC else { return }
                generateGridVC = segueContainer
                generateGridVC?.onCompletion = {
                    self.generatedGridContainerView.isHidden = true
                    self.guessGridContainerView.isHidden = false
                    self.generateGrid()
                }
            }
        }
    }
}
