//
//  Rotation.swift
//  AOC25
//
//  Created by Christopher Wainwright on 28/12/2025.
//

import Parser

enum Direction: String, CaseIterable {
    case r = "R"
    case l = "L"
}

enum Rotation: Equatable, CustomStringConvertible {
    case r(Int), l(Int)
    
    init(_ direction: Direction, value: Int) {
        switch direction {
        case .r: self = .r(value)
        case .l: self = .l(value)
        }
    }
    
    var description: String {
        switch self {
        case .r(let i): "R\(String(format: "%04d", i))"
        case .l(let i): "L\(String(format: "%04d", i))"
        }
    }
    
    var direction: Direction {
        switch self {
        case .r: return .r
        case .l: return .l
        }
    }
    
    var polarity: Int {
        switch self {
        case .r: return 1
        case .l: return -1
        }
    }
    
    var unsignedValue: Int {
        switch self {
        case .r(let i): i
        case .l(let i): i
        }
    }
    
    var value: Int {
        polarity * unsignedValue
    }
}

extension Rotation: Parsable {
    static var parser: Parser<Rotation> {
        .init { input in
            let direction = try Parser<Direction>.enumeration().run(&input)
            let value = try Parser.number().run(&input)
            return Rotation(direction, value: value)
        }
    }
}

let fileParser: Parser<[Rotation]> = Rotation.parser.sequence(separator: Parser.newline())
