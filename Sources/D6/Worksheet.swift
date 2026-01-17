//
//  Worksheet.swift
//  AOC25
//
//  Created by Christopher Wainwright on 31/12/2025.
//

import Foundation
import Parser

public typealias Values = [[Int]]

public enum Operation: String, CaseIterable, Sendable {
    case multiply = "*"
    case add = "+"
    
    var op: (Int, Int) -> Int {
        switch self {
        case .multiply:
            return (*)
        case .add:
            return (+)
        }
    }
}

protocol Worksheet: Parsable {
    var values: [[Int]] { get }
    var operations: [Operation] { get }
}

extension Worksheet {
    static var operationsParser: Parser<[Operation]> {
        Parser<Operation>.enumeration().sequence(separator: .space())
    }
}

extension Worksheet {
    public var evaluateColumns: [Int] {
        zip(self.values, self.operations).map { column, operation in
            let initialValue = switch operation {
                case .multiply: 1
                case .add: 0
            }
            
            return column.reduce(initialValue) { result, value in
                operation.op(result, value)
            }
        }
    }
    
    public var evaluate: Int {
        self.evaluateColumns.reduce(0, +)
    }
}

struct ColumnsWorksheet: Worksheet {
    let values: [[Int]]
    let operations: [Operation]
    
    static var valuesParser: Parser<[[Int]]> {
        //        Parser.optionalWhitespace() *> (Parser.number().sequence(separator: .space())).sequence(separator: .newline(), allowTrailingSeparator: true)
        (.space().optional(defaultValue: "") *> .number()).many(allowEmpty: false).sequence(separator: .newline(), allowTrailingSeparator: true)
    }

    public static var parser: Parser<Self> {
        .init { input in
            let values = try valuesParser.run(&input)
            let operations = try operationsParser.run(&input)
            
            
            guard let cols = values.first?.count
            else { fatalError("Could not determine size of columns") }
            var reorientedValues: [[Int]] = Array(repeating: [], count: cols)
            
            values.forEach { row in
                row.enumerated().forEach { j, element in
                    reorientedValues[j].append(element)
                }
            }
            
            return .init(values: reorientedValues, operations: operations)
        }
    }
}

public struct CephalopodWorksheet: Worksheet {
    let values: [[Int]]
    let operations: [Operation]
    
    static func lineSegmentsParser(_ sizes: [Int]) -> Parser<[[Int?]]> {
        var segmentParser: Parser<[Int?]> {
            .init { $0.map(String.init).map(Int.init) }
        }
        
        return .init { input in
            try sizes.map { size in
                let segment = if size != 0 {
                    input.prefix(size + 1) // to handle trailing whitespace
                } else {
                    input.prefix { !$0.isNewline }
                }
                input.removeFirst(segment.count)
                return try segmentParser.run(segment)
            }
        }
    }
    
    static func valuesParser(_ sizes: [Int]) -> Parser<[[[Int?]]]> {
        lineSegmentsParser(sizes)
            .sequence(separator: .newline(), allowTrailingSeparator: true)
            .map { $0.transposed() }
            .map { $0.map { $0.dropLast() } }
    }
    
    static func flattenColumns(columns: [[[Int?]]]) -> [[Int]] {
        columns.map { column in
            guard
                let maxWidth = column.map({ $0.dropLast { $0 == nil } }).map(\.count).max(),
                maxWidth != 0
            else { fatalError("No row for column found!") }
        
            let normalizedColumn = column.map { row in
                if row.count < maxWidth {
                    row + Array(repeating: nil, count: maxWidth - row.count)
                } else if row.count > maxWidth {
                    Array(row.dropLast(row.count - maxWidth))
                } else {
                    row
                }
            }
            
            let base = Array(repeating: 0, count: maxWidth)
            let results = normalizedColumn.reduce(base) { partialResult, row in
                let zipped = zip(row, partialResult)
                    .map { value, res in
                        if let value {
                            return res * 10 + value
                        } else {
                            return res
                        }
                    }
                return zipped
            }
            return results
        }
    }
    
    static public var parser: Parser<CephalopodWorksheet> {
        .init { input in
            let dataInput = try Parser<String>.until(terminator: Parser<Operation>.enumeration()).run(&input)
            let operationsInput = String(input)
            
            let operationsParser: Parser<[(Operation, Int)]> = (Parser<Operation>.enumeration() <*> .whitespace().map(\.count))
                .many()
                .map { if let last = $0.last { Array($0.dropLast() + [(last.0, 0)]) } else { $0 } } // ensure final space is treated differently
            let operations = try operationsParser.run(operationsInput)
            
            let dataSizes = operations.map(\.1)
            let values = try valuesParser(dataSizes).run(dataInput)
            
            let data = flattenColumns(columns: values)
            
            return .init(values: data, operations: operations.map(\.0))
        }
    }
}

func pow(_ x: Int, _ y: Int) -> Int {
    (0..<y).reduce(1) { partial, _ in  partial * x }
}

/// https://stackoverflow.com/questions/39889568/how-to-transpose-an-array-more-swiftly
extension Collection where Element: Collection, Element.Index == Index, Element.Element == Element.Element {
    /// Transposes a rectangular collection-of-collections (e.g. [[T]]) into its columns.
    /// Returns an empty array if the receiver is empty.
    func transposed<T>() -> [[T]] where Element.Element == T {
        guard let firstRow = self.first else { return [] }
        return firstRow.indices.map { index in
            self.map { row in
                row[index]
            }
        }
    }
}

extension Array {
    public func dropLast(while predicate: (Element) throws -> Bool) rethrows -> Self {
        var result = self
        while let lastItem = result.last, try predicate(lastItem) {
            result = result.dropLast()
        }
        return result
    }
}

infix operator <*> : AdditionPrecedence
public func <*><T, U>(lhs: Parser<T>, rhs: Parser<U>) -> Parser<(T, U)> {
    .init { input in
        let lhsResult = try lhs.run(&input)
        let rhsResult = try rhs.run(&input)
        return (lhsResult, rhsResult)
    }.atomic()
}
