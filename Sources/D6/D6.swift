//
//  D6.swift
//  AOC25
//
//  Created by Christopher Wainwright on 31/12/2025.
//

import Foundation

@main
struct D6 {
    static func main() throws {
        let input = try String(contentsOf: Bundle.module.url(forResource: "input", withExtension: "txt")!, encoding: .utf8)
    
        let parsedWorksheet = try ColumnsWorksheet.parser.run(input)
        print(parsedWorksheet.evaluateColumns)
        print(parsedWorksheet.evaluate)
        
        let cephalopodsWorksheet = try CephalopodWorksheet.parser.run(input)
        print(cephalopodsWorksheet.evaluateColumns)
        print(cephalopodsWorksheet.evaluate)
    }
}
