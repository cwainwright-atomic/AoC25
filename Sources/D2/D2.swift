//
//  D2.swift
//  AOC25
//
//  Created by Christopher Wainwright on 29/12/2025.
//

import Foundation

@main
struct D2 {
    static func main() throws {
        let input = try String(contentsOf: Bundle.module.url(forResource: "input", withExtension: "txt")!, encoding: .utf8)
        let idPairs: [ClosedRange<Int>] = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .split(separator: ",")
            .compactMap { part in
                let sections = part.split(separator: "-", maxSplits: 1)
                guard sections.count == 2,
                      let lower = Int(String(sections[0])),
                      let upper = Int(String(sections[1])) else {
                    return nil
                }
                return (lower...upper)
            }
        
        
        let invalidSum1 = idPairs
            .flatMap { $0.filter(\.invalidId1) }
            .reduce(0) { $0 + $1 }
        print(invalidSum1)
        
        let invalidSum2 = idPairs
            .flatMap { $0.filter(\.invalidId2) }
            .reduce(0) { $0 + $1 }
        print(invalidSum2)
    }
}
