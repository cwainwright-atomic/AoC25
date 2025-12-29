//
//  SophisticatedDial.swift
//  AOC25
//
//  Created by Christopher Wainwright on 28/12/2025.
//

import Foundation

struct SophisticatedComplexDial: OriginCounterDial {
    var originCount: Int = 0
    
    var range: ClosedRange<Int>
    var position: Int
    
    init(position: Int, range: ClosedRange<Int>) {
        self.position = position
        self.range = range
        
        self.originCount = 0
    }
    
    mutating func rotate(by rotation: Rotation) {
        let modulo = range.count
        let initialPosition = position
        let clicks = rotation.value
        
        // Exit function early if rotation is 0
        guard clicks != 0 else { return }
        
        // Calculate Passes of 0
        let step = clicks > 0 ? 1 : -1
        let steps = abs(clicks)

        // smallest positive k such that a + k*step ≡ 0 (mod N)
        let k0 = ((-initialPosition * step) % modulo + modulo) % modulo
        let firstHit = (k0 == 0) ? modulo : k0

        originCount +=
            firstHit <= steps
            ? 1 + (steps - firstHit) / modulo
            : 0
        
        // Calculate New Position
        let newPosition = (self.position + rotation.value) % modulo
        if newPosition < range.lowerBound {
            position = range.upperBound + 1 + newPosition
        } else if self.position > range.upperBound {
            position = range.lowerBound + newPosition
        } else {
            position = newPosition
        }
    }
}
