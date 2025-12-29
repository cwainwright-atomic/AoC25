//
//  NaiveDials.swift
//  AOC25
//
//  Created by Christopher Wainwright on 28/12/2025.
//


struct NaiveBasicDial: OriginCounterDial {
    var originCount: Int = 0
    
    var range: ClosedRange<Int>
    var position: Int
    
    init(initialPosition position: Int, range: ClosedRange<Int>) {
        self.position = position
        self.range = range
        
        self.originCount = 0
    }
    
    mutating func rotate(by rotation: Rotation) {
        let newPosition = rotation.value.advanced(by: position) % range.count
        
        position = newPosition >= range.lowerBound
        ? newPosition
        : 1 + range.upperBound + newPosition
        
        checkOrigin()
    }
}

struct NaiveComplexDial: OriginCounterDial {
    var originCount: Int = 0
    
    var range: ClosedRange<Int>
    var position: Int
    
    init(position: Int, range: ClosedRange<Int>) {
        self.position = position
        self.range = range
        
        self.originCount = 0
    }

    mutating func rotate(by rotation: Rotation) {
        let polarity = rotation.polarity
        
        (0..<rotation.unsignedValue).forEach { i in
            position += polarity
            
            if position < range.lowerBound {
                position = range.upperBound
            } else if position > range.upperBound {
                position = range.lowerBound
            }
            
            checkOrigin()
        }
    }
}
