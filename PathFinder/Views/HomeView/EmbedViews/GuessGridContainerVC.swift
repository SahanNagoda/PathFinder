//
//  GuessGridContanerVC.swift
//  PathFinder
//
//  Created by Sahan Nagodavithana on 4/26/24.
//

import UIKit

class GuessGridContainerVC: UIViewController {

    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    var guessGridTableVC: GuessGridTableViewController?
    private var rowCount: Int = 0
    private var columnCount: Int = 0
    
    var onCompletion: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

}

//MARK: Custom Methods
extension GuessGridContainerVC {
    func configure(){
        disableContinueButton()
    }
    
    func setupGrid(row: Int, column: Int){
        self.columnCount = column
        self.rowCount = row
        guessGridTableVC?.setupGrid(row: row, column: column)
        disableContinueButton()
    }
    
    func enableContinueButton() {
        continueButton.isEnabled = true
        continueButton.backgroundColor = .primaryOrange500
    }
    
    func disableContinueButton() {
        continueButton.isEnabled = false
        continueButton.backgroundColor = .neutral200
    }
}

//MARK: Segue
extension GuessGridContainerVC {
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

//MARK: IBAction
extension GuessGridContainerVC {
    @IBAction func continuePressed(_ sender: Any) {
        onCompletion?()
    }
}
