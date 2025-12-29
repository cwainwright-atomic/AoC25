//
//  DialProtocols.swift
//  AOC25
//
//  Created by Christopher Wainwright on 28/12/2025.
//


protocol Dial {
    var range: ClosedRange<Int> { get }
    var position: Int { get set }
    
    mutating func rotate(by rotation: Rotation)
}

protocol OriginCounterDial: Dial {
    var originCount: Int { get set }
    
    mutating func checkOrigin()
}

extension OriginCounterDial {
    mutating func checkOrigin() {
        if position == 0 {
            originCount += 1
        }
    }
}
