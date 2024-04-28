//
//  GuessGridContanerVC.swift
//  PathFinder
//
//  Created by Sahan Nagodavithana on 4/26/24.
//

import UIKit

/// View controller managing the container view for the guess grid.
class GuessGridContainerVC: UIViewController {
    
    /// Button to continue to the next screen.
    @IBOutlet weak var continueButton: UIButton!
    
    /// Container view holding the guess grid.
    @IBOutlet weak var containerView: UIView!
    
    /// The view controller managing the guess grid table.
    var guessGridTableVC: GuessGridTableViewController?
    
    /// The number of rows in the guess grid.
    private var rowCount: Int = 0
    
    /// The number of columns in the guess grid.
    private var columnCount: Int = 0
    
    /// A closure to be executed when the user completes their guess.
    var onCompletion: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
}

// MARK: - Custom Methods
extension GuessGridContainerVC {
    
    /// Configures the initial setup of the view controller.
    func configure(){
        disableContinueButton()
    }
    
    /// Sets up the guess grid with the specified number of rows and columns.
    ///
    /// - Parameters:
    ///   - row: The number of rows in the grid.
    ///   - column: The number of columns in the grid.
    func setupGrid(row: Int, column: Int){
        self.columnCount = column
        self.rowCount = row
        guessGridTableVC?.setupGrid(row: row, column: column)
        disableContinueButton()
    }
    
    /// Enables the continue button.
    func enableContinueButton() {
        continueButton.isEnabled = true
        continueButton.backgroundColor = .primaryOrange500
    }
    
    /// Disables the continue button.
    func disableContinueButton() {
        continueButton.isEnabled = false
        continueButton.backgroundColor = .neutral200
    }
}

// MARK: - Segue
extension GuessGridContainerVC {
    
    /// Prepares for navigation to other view controllers based on segues.
    ///
    /// - Parameters:
    ///   - segue: The segue that triggered the transition.
    ///   - sender: The object that initiated the segue.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GuessGridTableSegue" {
            if (segue.destination .isKind(of: GuessGridTableViewController.self)) {
                guard let segueContainer = segue.destination as?  GuessGridTableViewController else { return }
                guessGridTableVC = segueContainer
                guessGridTableVC?.onChangeCompletion = { row, column in
                    if row == self.rowCount && column == self.columnCount {
                        self.enableContinueButton()
                    } else {
                        self.disableContinueButton()
                    }
                }
            }
        }
    }
}

// MARK: - IBAction
extension GuessGridContainerVC {
    
    /// Handles the action when the continue button is pressed.
    @IBAction func continuePressed(_ sender: Any) {
        onCompletion?()
    }
}
