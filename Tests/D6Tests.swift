//
//  D6Tests.swift
//  AOC25
//
//  Created by Christopher Wainwright on 01/01/2026.
//

import Foundation
import Testing
@testable import D6

@Suite("D6")
struct D6Tests {
    @Suite("Part 1")
    struct P1 {
        @Test("Test Input")
        func testInput() async throws {
            let input = try String(contentsOf: Bundle.module.url(forResource: "test", withExtension: "txt")!, encoding: .utf8)
            let worksheet = try ColumnsWorksheet.parser.run(input)
            
            #expect(worksheet.evaluateColumns == [33210, 490, 4243455, 401])
            #expect(worksheet.evaluate == 4277556)
        }
    }
    
    @Suite("Part 2")
    struct P2 {
        @Test("Test Input")
        func testInput() async throws {
            let input = try String(contentsOf: Bundle.module.url(forResource: "test", withExtension: "txt")!, encoding: .utf8)
            
            let res = try CephalopodWorksheet.parser.run(input)
            #expect(res.evaluate == 3263827)
        }
        
        @Test("Puzzle Input")
        func puzzleInput() async throws {
            let input = try String(contentsOf: Bundle.module.url(forResource: "input", withExtension: "txt")!, encoding: .utf8)
            
            let res = try CephalopodWorksheet.parser.run(input)
            #expect(res.evaluate == 9627174150897)
        }
    }
    
}
