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

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

}

// MARK: Custom Methods
extension HomeViewController {
    func configure() {
        baseNavigationBarConfigurations()
        showNavigationBar()
        title = "Pronto - Path Finder"
    }
}

//MARK: Segue
extension HomeViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GuessGridSegue" {
            if (segue.destination .isKind(of: GuessGridContainerVC.self)) {
                guard let segueContainer = segue.destination as?  GuessGridContainerVC else { return }
                guessGridVC = segueContainer
                guessGridVC?.rowCount = rowCount
                guessGridVC?.columnCount = columnCount
                guessGridVC?.onCompletion = {
                    guard let vc = AppStoryboards.mainStoryboard()
                        .instantiateViewController(identifier: "GameViewController") as? GameViewController else { return }
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        } else if segue.identifier == "GenerateGridSegue" {
            if (segue.destination .isKind(of: GenerateGridVC.self)) {
                guard let segueContainer = segue.destination as?  GenerateGridVC else { return }
                generateGridVC = segueContainer
                generateGridVC?.onCompletion = {
                    
                }
            }
        }
    }
}
