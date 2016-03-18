//
//  Array+Subscript.swift
//
//  Created by Joachim Kret on 18/03/16.
//  Copyright © 2016 Joachim Kret. All rights reserved.
//

import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}