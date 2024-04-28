//
//  LeaderBoardTableViewCell.swift
//  PathFinder
//
//  Created by Sahan Nagodavithana on 4/27/24.
//

import UIKit

/// A custom table view cell displaying information for a single game state in the leaderboard.
class LeaderBoardTableViewCell: UITableViewCell {
    
    /// The label displaying the rank of the game state.
    @IBOutlet weak var rankLabel: UILabel!
    
    /// The label displaying the size of the grid in the game state.
    @IBOutlet weak var sizeLabel: UILabel!
    
    /// The label displaying the number of moves taken in the game state.
    @IBOutlet weak var movesLabel: UILabel!
    
    /// The label displaying the time taken to complete the game state.
    @IBOutlet weak var timeLabel: UILabel!
    
    /// Returns the reusable identifier for the cell used in the rows of the leaderboard table view.
    class func rowCellIdentifier() -> String {
        return "LeaderBoardTableViewCell"
    }
    
    /// Returns the reusable identifier for the cell used in the header of the leaderboard table view.
    class func headerCellIdentifier() -> String {
        return "LeaderBoardTableViewHeaderCell"
    }
    
    /// Configures the cell with information from a game state and its rank.
    ///
    /// - Parameters:
    ///   - state: The game state to display.
    ///   - rank: The rank of the game state in the leaderboard.
    func setupCell(state: GameState, rank: Int){
        rankLabel.text = String(rank)
        sizeLabel.text = String(state.gridSize)
        movesLabel.text = String(state.stepCount)
        if let endTime = state.endTime {
            timeLabel.text = GameCalculations().getDifferenceFromTwoDates(start: state.startTime, end: endTime)
        }
        
    }
    
    
}
