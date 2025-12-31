//
//  D4.swift
//  AOC25
//
//  Created by Christopher Wainwright on 30/12/2025.
//

import Foundation

@main
struct D4 {
    static func main() throws {
        let input = try String(contentsOf: Bundle.module.url(forResource: "input", withExtension: "txt")!)
        let departmentMap = try PrintingDepartmentMap.parser.run(input)
        
        let accessibleRollList = departmentMap
            .findAccessibleRolls()
        print(accessibleRollList.count)
        
        var mutableMap = departmentMap
        var totalAccessibleRollCount = 0
        while true {
            let accessibleRollList = mutableMap.findAccessibleRolls()
            guard !accessibleRollList.isEmpty else { break }
            
            totalAccessibleRollCount += accessibleRollList.count
            accessibleRollList.forEach {
                mutableMap[$0.coordinate.x, $0.coordinate.y] = .collected
            }
        }
        
        print(totalAccessibleRollCount)
    }
}
