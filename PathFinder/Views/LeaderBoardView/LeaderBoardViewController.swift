//
//  LeaderBoardViewController.swift
//  PathFinder
//
//  Created by Sahan Nagodavithana on 4/27/24.
//

import UIKit

/// A view controller displaying the leaderboard.
class LeaderBoardViewController: UIViewController {
    
    /// The data source managing the leaderboard table view.
    @IBOutlet var dataSource: LeaderBoardDataSource!
    
    /// The table view displaying the leaderboard.
    @IBOutlet weak var tableView: UITableView!
    
    /// The constraint controlling the height of the table view.
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    /// A text view displaying additional information about a selected game state.
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
}

// MARK: - Custom Methods
extension LeaderBoardViewController {
    
    /// Configures the initial setup of the view controller.
    func configure() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        title = "Path Finder Leader Board"
        
        let history = RealmManager.shared.getLeaderBoard()
        dataSource.gameHistory = history
        dataSource.reloadList(tableView: tableView)
        dataSource.onCompletion = { [weak self] state in
            let text =  "This round was completed at \(state.endTime?.toString(dateFormat: "dd/MM/yyyy hh:mm:ss") ?? ""). "
            self?.textView.text = String(repeating: text, count: state.gridSize)
        }
        
        tableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
        textView.text = ""
    }
    
    /// Observes changes in the content size of the table view and adjusts its height accordingly.
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(keyPath == "contentSize") {
            if let newvalue = change?[.newKey] {
                let newsize  = newvalue as! CGSize
                tableViewHeightConstraint.constant = newsize.height
                
            }
        }
    }
}

// MARK: - IBAction
extension LeaderBoardViewController {
    
    /// Handles the action when the "New Game" button is pressed.
    @IBAction func newGamePressed(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}
