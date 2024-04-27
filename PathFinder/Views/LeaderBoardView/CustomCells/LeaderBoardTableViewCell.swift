//
//  LeaderBoardTableViewCell.swift
//  PathFinder
//
//  Created by Sahan Nagodavithana on 4/27/24.
//

import UIKit

class LeaderBoardTableViewCell: UITableViewCell {

    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var movesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    class func rowCellIdentifier() -> String {
        return "LeaderBoardTableViewCell"
    }

    class func headerCellIdentifier() -> String {
        return "LeaderBoardTableViewHeaderCell"
    }
    
    func setupCell(state: GameState, rank: Int){
        rankLabel.text = String(rank)
        sizeLabel.text = String(state.gridSize)
        movesLabel.text = String(state.stepCount)
        if let endTime = state.endTime {
            timeLabel.text = getDifferenceFromTwoDates(start: state.startTime, end: endTime)
        }
        
    }
    
    func getDifferenceFromTwoDates(start: Date, end: Date) -> String {

           let diff = Int(end.timeIntervalSince1970 - start.timeIntervalSince1970)

           let hours = diff / 3600
           let minutes = (diff - hours * 3600) / 60
           let seconds = (diff - hours * 3600 - minutes * 60)
           return String(format: "%02d:%02d min", minutes, seconds)
       }

}
