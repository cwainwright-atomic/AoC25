//
//  D5.swift
//  AOC25
//
//  Created by Christopher Wainwright on 31/12/2025.
//

import Foundation

@main
struct D5 {
    static func main() throws {
        let input = try String(contentsOf: Bundle.module.url(forResource: "input", withExtension: "txt")!, encoding: .utf8)
        let ingredientData = try IngredientData.parser.run(input)
        
        let freshCount = ingredientData.availableIngredients.reduce(0) { count, ingredient in
            if (
                ingredientData.ingredientRanges.contains { $0.contains(ingredient) }
            ) { count + 1 } else { count }
        }
        print(freshCount)
        
        
        let sortedRanges = ingredientData
            .ingredientRanges
            .sorted {
                $0.lowerBound == $1.lowerBound ?
                $0.upperBound < $1.upperBound :
                $0.lowerBound < $1.lowerBound
            }
        
        let combinedRanges = sortedRanges
            .dropFirst()
            .reduce(
                sortedRanges.first.map { [$0] } ?? []
            ) { combinedRanges, range in
                guard let lastRange = combinedRanges.last
                else  { return combinedRanges }
                                
                // If contained inside prior range, ignore
                if lastRange.overlaps(range) {
                    return combinedRanges.dropLast() + [(min(lastRange.lowerBound, range.lowerBound)...max(lastRange.upperBound, range.upperBound))]
                }
                
                return combinedRanges + [range]
            }
        
        let totalCount = combinedRanges
            .reduce(0) { count, range in
                count + (range.count)
            }
        
        print(totalCount)
    }
}
