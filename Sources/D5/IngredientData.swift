//
//  IngredientData.swift
//  AOC25
//
//  Created by Christopher Wainwright on 31/12/2025.
//

import Parser

struct IngredientData {
    let ingredientRanges: [ClosedRange<Int>]
    let availableIngredients: [Int]
}

extension Int: @retroactive Parsable {
    public static var parser: Parser<Int> {
        .number()
    }
}

extension ClosedRange: @retroactive Parsable where Bound: Parsable {
    public static var parser: Parser<ClosedRange<Bound>> {
        .init { input in
            let lower = try Bound.parse(&input)
            try Parser<String>.token("-").discard().run(&input)
            let upper = try Bound.parse(&input)
            return (lower...upper)
        }
    }
}

extension IngredientData: Parsable {
    static var parser: Parser<IngredientData> {
        .init { input in
            let ranges = try ClosedRange<Int>.parser.sequence(separator: .token("\n")).run(&input)
            try Parser<String>.token("\n").discard().run(&input)
            let available = try Int.parser.sequence(separator: .token("\n")).run(&input)
            
            return .init(ingredientRanges: ranges, availableIngredients: available)
        }
    }
}
