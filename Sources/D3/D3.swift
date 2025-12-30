//
//  D3.swift
//  AOC25
//
//  Created by Christopher Wainwright on 29/12/2025.
//

import Foundation

@main
struct D3 {
    static func main() throws {
        let input = try String(contentsOfFile: Bundle.module.path(forResource: "input", ofType: "txt")!, encoding: .utf8)
        let batteryBanks = BatteryBank.parse(input)
        
        let activatedBatteryBanks1 = batteryBanks.compactMap { $0.activate(withSafety: .on) }
        let outputJoltage1 = activatedBatteryBanks1.reduce(0) { $0 + $1.jolts }
        print(outputJoltage1)
        
        let activatedBatteryBanks2 = batteryBanks.compactMap { $0.activate(withSafety: .off(count: 12)) }
        let outputJoltage2 = activatedBatteryBanks2.reduce(0) { $0 + $1.jolts }
        print(outputJoltage2)
    }
}
