// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

@main
struct D1 {
    static func main() throws {        
        let input = try String(contentsOf: Bundle.module.url(forResource: "rotations", withExtension: "txt")!, encoding: .utf8)
        let rotations: [Rotation] = try fileParser.run(input)
        
        var dial1: NaiveBasicDial = .init(initialPosition: 50, range: (0...99))
        
        rotations.forEach { rotation in
            dial1.rotate(by: rotation)
        }
        
        print("P1 Dial Count: \(dial1.originCount)")
        
        var dial2: SophisticatedComplexDial = .init(position: 50, range: (0...99))
        rotations.forEach { rotation in
            dial2.rotate(by: rotation)
        }
        
        print("P2 Dial Count: \(dial2.originCount)")
    }
}
