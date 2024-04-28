//
//  LeaderBoardDataSource.swift
//  PathFinder
//
//  Created by Sahan Nagodavithana on 4/27/24.
//

import UIKit

/// A data source managing the leaderboard table view.
class LeaderBoardDataSource: NSObject {
    
    /// An array holding the game history entries.
    var gameHistory: [GameState] = []
    
    /// A closure to be executed when a game state is selected from the leaderboard.
    var onCompletion: ((GameState) -> Void)?
    
    /// Reloads the leaderboard table view.
    ///
    /// - Parameter tableView: The table view to reload.
    func reloadList(tableView: UITableView) {
        tableView.reloadData()
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension LeaderBoardDataSource: UITableViewDelegate, UITableViewDataSource {
    
    /// Returns the number of sections in the leaderboard table view.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    /// Returns the number of rows in each section of the leaderboard table view.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return gameHistory.count
        }
    }
    
    /// Returns the cell for a specific row in the leaderboard table view.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: LeaderBoardTableViewCell.headerCellIdentifier(),
                                                     for: indexPath) as! LeaderBoardTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: LeaderBoardTableViewCell.rowCellIdentifier(),
                                                     for: indexPath) as! LeaderBoardTableViewCell
            cell.setupCell(state: gameHistory[indexPath.row], rank: indexPath.row + 1)
            return cell
        }
    }
    
    /// Handles the selection of a row in the leaderboard table view.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onCompletion?(gameHistory[indexPath.row])
    }
}
