//
//  D1Tests.swift
//  AOC25
//
//  Created by Christopher Wainwright on 28/12/2025.
//

import Foundation
import Testing

@testable import D1

@Suite("D1")
struct D1Tests {
    @Test("Naive Dial Tests")
    func naiveDialTests() async throws {
        let input = try String(contentsOf: Bundle.module.url(forResource: "test", withExtension: "txt")!, encoding: .utf8)
        let rotations: [Rotation] = try fileParser.run(input)
        
        var naiveDial: NaiveComplexDial = .init(position: 50, range: (0...99))
        var sophisticatedDial: SophisticatedComplexDial = .init(position: 50, range: (0...99))
        
        for rotation in rotations {
            naiveDial.rotate(by: rotation)
            sophisticatedDial.rotate(by: rotation)
            
            #expect(naiveDial.position == sophisticatedDial.position)
            #expect(naiveDial.originCount == sophisticatedDial.originCount, "\(naiveDial.originCount) != \(sophisticatedDial.originCount)")
        }
    }
}
