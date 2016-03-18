//
//  String+Subscript.swift
//  lastfm
//
//  Created by Joachim on 18/03/16.
//  Copyright © 2016 Joachim Kret. All rights reserved.
//

import Foundation

extension String {
    subscript (safe integerIndex: Int) -> Character? {
        if integerIndex < 0 || integerIndex >= characters.count {
            return nil
        } else {
            let index = startIndex.advancedBy(integerIndex)
            return self[index]
        }
    }
    
    subscript(integerIndex: Int) -> Character {
        let index = startIndex.advancedBy(integerIndex)
        return self[index]
    }
    
    subscript(integerRange: Range<Int>) -> String {
        let start = startIndex.advancedBy(integerRange.startIndex)
        let end = startIndex.advancedBy(integerRange.endIndex)
        let range = start..<end
        return self[range]
    }
}