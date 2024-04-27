//
//  GuessGridTableViewController.swift
//  PathFinder
//
//  Created by Sahan Nagodavithana on 4/26/24.
//

import UIKit

class GuessGridTableViewController: UITableViewController {

    @IBOutlet weak var rowQtyView: PickingQtyView!
    @IBOutlet weak var columnQtyView: PickingQtyView!
    @IBOutlet weak var hintLabel: UILabel!
    
    // (Row, Column)
    var onChangeCompletion: ((Int, Int) -> Void)?
    private var rowCount: Int = 0
    private var columnCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }


}

//MARK: Custom Methods
extension GuessGridTableViewController {
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
    
    func setupGrid(row: Int, column: Int){
        self.columnCount = column
        self.rowCount = row
        configure()
    }
    
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

//MARK: TableView Delegates
extension GuessGridTableViewController {
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
    }
}
