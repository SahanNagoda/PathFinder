//
//  LeaderBoardViewController.swift
//  PathFinder
//
//  Created by Sahan Nagodavithana on 4/27/24.
//

import UIKit

class LeaderBoardViewController: UIViewController {

    @IBOutlet var dataSource: LeaderBoardDataSource!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
}

//MARK: Custom Methods
extension LeaderBoardViewController {
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
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(keyPath == "contentSize") {
            if let newvalue = change?[.newKey] {
                let newsize  = newvalue as! CGSize
                tableViewHeightConstraint.constant = newsize.height

            }
        }
    }
}

//MARK: IBAction
extension LeaderBoardViewController {
    @IBAction func newGamePressed(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}
