//
//  BatteryBank.swift
//  AOC25
//
//  Created by Christopher Wainwright on 29/12/2025.
//

import Foundation

typealias BatteryBank = [Int]

extension BatteryBank {
    static func parse(_ input: String) -> [BatteryBank] {
        input.split(separator: "\n").map {
            $0.map(String.init).compactMap(Int.init)
        }
    }
    
    private func safeActivationIndexes() -> Set<Int> {
        // Get largest elements, prioritised by smallest index (ignoring last element which is useless for tens unit)
        let tensBattery = (self
            .dropLast()
            .enumerated()
            .sorted {
                $0.element == $1.element
                ? $0.offset < $1.offset
                : $0.element > $1.element
            }
            .first!
        )
        
        // Get largest element after tens index
        let unitsBattery = (self
            .enumerated()
            .dropFirst(tensBattery.offset + 1)
            .sorted {
                $0.element > $1.element
            }
            .first!
        )
        
        return [tensBattery.offset, unitsBattery.offset]
    }
    
    private func unsafeActivationIndexes(batteryCount: Int = 12) -> Set<Int> {
        func optimalSubsetSelection(remaining: Int, subset: [(offset: Int, element: Int)]) -> (index: Int, nextSubset: [(offset: Int, element: Int)]) {
            let maximumSelectionIndex = self.count - remaining
            
            // Remove offsets which would (if selected) empty set before index selection process is complete
            let selectionSet = subset
                .filter { $0.offset <= maximumSelectionIndex }
            
            // Select best candidate for next digit (assumes subset has been sorted by descending element, then ascending offset)
            guard let selection = selectionSet.first else { fatalError("Selection set for \(batteryCount-remaining) is empty!") }
            
            // Remove offsets prior to selection
            let nextSubset = subset.filter { $0.offset > selection.offset }
            
            // Return offset of selected element and next subset selection
            return (selection.offset, nextSubset)
        }

        // Sort by element and then offset (prioritising smaller offsets when elements are equal)
        let sortedEnumeration = self
            .enumerated()
            .sorted {
                $0.element == $1.element
                ? $0.offset < $1.offset
                : $0.element > $1.element
            }
    
        // Reduce with count down and shrink subset
        let (indexSet, _) = (1...batteryCount)
            .reversed()
            .reduce((indexes: Set<Int>.init(), subset: sortedEnumeration)) { partialResult, remaining in
                let (nextIndex, nextSubset) = optimalSubsetSelection(remaining: remaining, subset: partialResult.subset)
                
                return (
                    indexes: partialResult.indexes.union([nextIndex]),
                    subset: nextSubset
                )
            }
        
        return indexSet
    }
    
    enum Safety {
        case on
        case off(count: Int)
    }
    
    func activate(withSafety safety: Safety = .on) -> BatteryBankActivated? {
        let activationIndexes = switch safety {
            case .on: safeActivationIndexes()
            case .off(let count): unsafeActivationIndexes(batteryCount: count)
        }
        
        return .init (
            batteryBank: self,
            activeBatteryIndexes: activationIndexes
        )
    }
}

struct BatteryBankActivated: CustomStringConvertible {
    let batteryBank: BatteryBank
    let activeBatteryIndexes: Set<Int>
    
    init(batteryBank: BatteryBank, activeBatteryIndexes: Set<Int>) {
        self.batteryBank = batteryBank
        self.activeBatteryIndexes = activeBatteryIndexes
    }
    
    var jolts: Int {
        activeBatteryIndexes.sorted(by: >).enumerated().reduce(0) { result, index in result + self.batteryBank[index.element] * Int(pow(10.0, Double(index.offset))) }
    }
    
    var adjacentBatteryIndexPairs: Zip2Sequence<Array<Int>.SubSequence, Array<Int>.SubSequence> {
        zip(activeBatteryIndexes.sorted(by: <).dropLast(), activeBatteryIndexes.sorted(by: <).dropFirst())
    }
    
    var description: String {
        """
        \(batteryBank.map(\.description).joined())
        \(
            activeBatteryIndexes
                .sorted(by: <)
                .first
                .map { String(repeating: " ", count: $0) } ?? ""
        )_\(
            adjacentBatteryIndexPairs
                .map { "\(String(repeating: " ", count: $0.1 - $0.0 - 1))_" }
                .joined()
        )
        """
    }
}
