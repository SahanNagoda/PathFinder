//
//  Date.swift
//  PathFinder
//
//  Created by Sahan Nagodavithana on 4/27/24.
//

import Foundation

extension Date {

    func toString( dateFormat format: String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
