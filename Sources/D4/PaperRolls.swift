//
//  PaperRolls.swift
//  AOC25
//
//  Created by Christopher Wainwright on 30/12/2025.
//

import Foundation
import Parser

public enum Space: String, Sendable, CaseIterable {
    case empty = "."
    case roll = "@"
    case collected = "x"
}

public typealias PrintingDepartmentMap = [[Space]]

extension PrintingDepartmentMap {
    func print() {
        Swift.print(self.map { $0.map { $0.rawValue }.joined() }.joined(separator: "\n"))
    }
}

extension PrintingDepartmentMap: @retroactive Parsable {
    public static var parser: Parser<[[Space]]> {
        Parser<Space>
            .enumeration()
            .many()
            .sequence(separator: .token("\n"))
    }
}

extension PrintingDepartmentMap {
    subscript(x: Int, y: Int) -> Space? {
        get {
            guard
                indices.contains(y),
                self[y].indices.contains(x)
            else { return nil }
            return self[y][x]
        }
        set {
            guard
                indices.contains(y),
                self[y].indices.contains(x),
                let newValue
            else { return }
            return self[y][x] = newValue
        }
    }
    
    func getAdjacentRolls(x: Int, y: Int) -> [Space?] {
        let adjacentOffsets = (-1...1)
            .flatMap { dx in (-1...1)
                    .map { dy in (dx: dx, dy: dy) }
                    .filter { $0.dx != 0 || $0.dy != 0 }
            }
        
        let adjacentSpaces = adjacentOffsets
            .map { (x: x + $0.dx, y: y + $0.dy) }
            .map { self[$0.x, $0.y] }
            
        return adjacentSpaces
    }
    
    func findAccessibleRolls() -> [(coordinate: (x: Int, y: Int), value: Space)] {
        self
            .indices
            .flatMap { y in self[y].enumerated().map { x, value in (coordinate: (x: x, y: y), value: value) } }
            .filter { _, value in value == .roll }
            .filter { coordinate, _ in self
                    .getAdjacentRolls(x: coordinate.0, y: coordinate.1)
                    .count { $0 == .roll } < 4
            }
    }
}
