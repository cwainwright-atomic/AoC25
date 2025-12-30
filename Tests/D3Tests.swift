//
//  D3Tests.swift
//  AOC25
//
//  Created by Christopher Wainwright on 30/12/2025.
//

import Foundation
import Testing

@testable import D3

@Suite("D3")
struct D3Tests {
    @Suite("Safe Activation")
    struct SafeActivationTests {
        @Test("Test Input")
        func testInput() async throws {
            let testInput = try String(contentsOf: Bundle.module.url(forResource: "test", withExtension: "txt")!)
            let parsedInput = BatteryBank.parse(testInput)
            
            #expect(parsedInput.count == 4)
            
            let activatedBatteryBanks = parsedInput.compactMap{ $0.activate() }

            #expect(activatedBatteryBanks.count == 4)
            
            let totalJolts = activatedBatteryBanks.reduce(0) { $0 + $1.jolts }
            
            #expect(totalJolts == 357)
        }
        
        @Test("Puzzle Input")
        func puzzleInput() async throws {
            let testInput = try String(contentsOf: Bundle.module.url(forResource: "input", withExtension: "txt")!)
            let parsedInput = BatteryBank.parse(testInput)
            
            #expect(parsedInput.count == 200)
            
            let activatedBatteryBanks = parsedInput.compactMap{ $0.activate() }

            #expect(activatedBatteryBanks.count == 200)
            
            let totalJolts = activatedBatteryBanks.reduce(0) { $0 + $1.jolts }
            
            #expect(totalJolts == 17535)
        }
    }
    
    @Suite("Unsafe Activation")
    struct UnsafeActivationTests {
        @Test("Test Input")
        func testInput() async throws {
            let testInput = try String(contentsOf: Bundle.module.url(forResource: "test", withExtension: "txt")!)
            let parsedInput = BatteryBank.parse(testInput)
            
            #expect(parsedInput.count == 4)
            
            let activatedBatteryBanks = parsedInput.compactMap{ $0.activate(withSafety: .off(count: 12)) }
            
            activatedBatteryBanks.forEach { print($0) }

            #expect(activatedBatteryBanks.count == 4)
            
            let totalJolts = activatedBatteryBanks.reduce(0) { $0 + $1.jolts }
            
            #expect(totalJolts == 3121910778619)
        }
        
        @Test("Puzzle Input")
        func puzzleInput() async throws {
            let testInput = try String(contentsOf: Bundle.module.url(forResource: "input", withExtension: "txt")!)
            let parsedInput = BatteryBank.parse(testInput)
            
            #expect(parsedInput.count == 200)
            
            let activatedBatteryBanks = parsedInput.compactMap{ $0.activate(withSafety: .off(count: 12)) }
            
            activatedBatteryBanks.forEach { print($0) }
            
            #expect(activatedBatteryBanks.count == 200)
            
            let totalJolts = activatedBatteryBanks.reduce(0) { $0 + $1.jolts }
            
            #expect(totalJolts == 173577199527257)
        }
    }
}
