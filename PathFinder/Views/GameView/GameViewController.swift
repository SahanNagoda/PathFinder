//
//  GameViewController.swift
//  PathFinder
//
//  Created by Sahan Nagodavithana on 4/25/24.
//

import UIKit

class GameViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        // Do any additional setup after loading the view.
    }

}

// MARK: Custom Methods
extension GameViewController {
    func configure() {
        baseNavigationBarConfigurations()
        showNavigationBar()
        title = "Pronto - Path Finder"
    }
}
