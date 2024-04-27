//
//  RealmResults.swift
//  PathFinder
//
//  Created by Sahan Nagodavithana on 4/27/24.
//

import Foundation
import RealmSwift

extension Results {
    func toArray() -> [Element] {
      return compactMap {
        $0
      }
    }
 }
