//
//  HomeViewController.swift
//  PathFinder
//
//  Created by Sahan Nagodavithana on 4/26/24.
//

import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var guessGridContainerView: UIView!
    @IBOutlet weak var generatedGridContainerView: UIView!
    
    var guessGridVC: GuessGridContainerVC?
    var generateGridVC: GenerateGridVC?
    
    var rowCount: Int = 4
    var columnCount: Int = 5
    
    var gameState: GameState?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configure()
    }

}

// MARK: Custom Methods
extension HomeViewController {
    func configure() {
        baseNavigationBarConfigurations()
        showNavigationBar()
        title = "Pronto - Path Finder"
        
        generatedGridContainerView.isHidden = false
        guessGridContainerView.isHidden = true
    }
    
    func generateGrid(){
        let randomRow = Int.random(in: 4...6)
        let randomColumn = Int.random(in: 4...6)
        
        self.rowCount = randomRow
        self.columnCount = randomColumn
        
        self.guessGridVC?.setupGrid(row: randomRow, column: randomColumn)
        
        self.gameState = GameCalculations().generateGameState(row: randomRow, column: randomColumn)
    }
    
}

//MARK: Segue
extension HomeViewController {
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
