//
//  GuessGridTableViewController.swift
//  PathFinder
//
//  Created by Sahan Nagodavithana on 4/26/24.
//

import UIKit

/// A view controller managing the guess grid table view.
class GuessGridTableViewController: UITableViewController {
    
    /// The view for selecting the number of rows in the guess grid.
    @IBOutlet weak var rowQtyView: PickingQtyView!
    
    /// The view for selecting the number of columns in the guess grid.
    @IBOutlet weak var columnQtyView: PickingQtyView!
    
    /// A label providing hints and feedback for the guess grid.
    @IBOutlet weak var hintLabel: UILabel!
    
    /// A closure to be executed when the number of rows and columns in the guess grid changes.
    var onChangeCompletion: ((Int, Int) -> Void)?
    
    /// The number of rows in the guess grid.
    private var rowCount: Int = 0
    
    /// The number of columns in the guess grid.
    private var columnCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
}

// MARK: - Custom Methods
extension GuessGridTableViewController {
    
    /// Configures the initial setup of the table view controller.
    func configure(){
        rowQtyView.count = 0
        columnQtyView.count = 0
        hintLabel.text = "Hint: Total number of cells is \(rowCount * columnCount)"
        rowQtyView.onChangeCompletion = { [weak self] _ in
            guard let self = self else { return }
            self.onChangeCompletion?(rowQtyView.count, columnQtyView.count)
            checkCount()
        }
        
        columnQtyView.onChangeCompletion = { [weak self] _ in
            guard let self = self else { return }
            self.onChangeCompletion?(rowQtyView.count, columnQtyView.count)
            checkCount()
        }
    }
    
    /// Sets up the guess grid with the specified number of rows and columns.
    ///
    /// - Parameters:
    ///   - row: The number of rows in the grid.
    ///   - column: The number of columns in the grid.
    func setupGrid(row: Int, column: Int){
        self.columnCount = column
        self.rowCount = row
        configure()
    }
    
    /// Checks if the selected number of rows and columns matches the actual grid size.
    func checkCount(){
        if rowCount == rowQtyView.count && columnCount == columnQtyView.count {
            hintLabel.text = "You guessed correctly. Press continue to go to the grid."
            tableView.beginUpdates()
            tableView.endUpdates()
        } else {
            hintLabel.text = "Hint: Total number of cells is \(rowCount * columnCount)"
        }
    }
}

// MARK: - TableView Delegates
extension GuessGridTableViewController {
    
    /// Specifies the appearance of cells before they are displayed.
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
    }
}
