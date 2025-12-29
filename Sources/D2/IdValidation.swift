//
//  IdValidation.swift
//  AOC25
//
//  Created by Christopher Wainwright on 29/12/2025.
//

import Foundation

extension Int {
    var invalidId1: Bool {
        let strVal = String(self)
        guard strVal.count % 2 == 0 else { return false }
        let prefix = strVal.prefix(strVal.count / 2)
        let suffix = strVal.suffix(strVal.count / 2)
        return prefix == suffix
    }
    
    var invalidId2: Bool {
        let strVal = String(self)
        if strVal.count < 2 { return false }
        return (1...strVal.count / 2)
            .filter { strVal.count % $0 == 0 }
            .contains { len in
                let prefix = strVal.prefix(len)
                let iterations = strVal.count / len
                return (0..<iterations).allSatisfy { iteration in
                    let start = strVal.index(strVal.startIndex, offsetBy: len * iteration)
                    let end = strVal.index(strVal.startIndex, offsetBy: len * (iteration + 1))
                    return strVal[start..<end] == prefix
                }
        }
    }
}
