//
//  LeaderBoardDataSource.swift
//  PathFinder
//
//  Created by Sahan Nagodavithana on 4/27/24.
//

import UIKit

class LeaderBoardDataSource: NSObject {
    var gameHistory: [GameState] = []
    var onCompletion: ((GameState) -> Void)?
    
    func reloadList(tableView: UITableView) {
        tableView.reloadData()
    }
    
}

extension LeaderBoardDataSource: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return gameHistory.count
        }
    }
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onCompletion?(gameHistory[indexPath.row])
    }
}
