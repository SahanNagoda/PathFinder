//
//  GenerateGridVC.swift
//  PathFinder
//
//  Created by Sahan Nagodavithana on 4/26/24.
//

import UIKit

class GenerateGridVC: UIViewController {
    
    var onCompletion: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

//MARK: IBAction
extension GenerateGridVC {
    @IBAction func generatePressed(_ sender: Any) {
        onCompletion?()
    }
}
