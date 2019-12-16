//
//  LFSR.swift
//

import Darwin

private let maximalTapsArray: [[UInt]] = [
  [2, 1], // period = 2 ^ 2 - 1 = 3
  [3, 2], // period = 2 ^ 3 - 1 = 7
  [4, 3], // .
  [5, 3], // .
  [6, 5], // .
  [7, 6],
  [8, 6, 5, 4],
  [9, 5],
  [10, 7],
  [11, 9],
  [12, 11, 10, 4],
  [13, 12, 11, 8],
  [14, 13, 12, 2],
  [15, 14],
  [16, 15, 13, 4],
  [17, 14],
  [18, 11],
  [19, 18, 17, 14],
  [20, 17],
  [21, 19],
  [22, 21],
  [23, 18],
  [24, 23, 22, 17]
]

private func maximalTaps(_ n: UInt) -> [UInt] {
  let i = UInt(log2(Double(n))) - 1
  guard i >= 0 && i < maximalTapsArray.count else { fatalError("No default taps available for out of bounds n = \(n).") }
  return maximalTapsArray[Int(i)]
}

public struct LFSR: IteratorProtocol, Codable {
  let n: UInt
  var state: UInt
  let degree: UInt
  let bound: UInt
  let taps: [UInt]
  
  public init(_ n: UInt, taps: [UInt]? = nil) {
    guard n > 1 else { fatalError("\(n) is out of range.") }
    self.n = n
    self.state = LFSR.randomUInt(n) + 1
    let taps = taps.map{ Array(Set($0)) }?.sorted().reversed() ?? maximalTaps(n)
    guard taps.count > 0 else { fatalError("Empty taps array.") }
    for tap in taps {
      guard tap > 0 else { fatalError("Taps must be positive. Saw \(tap).") }
    }
    self.taps = taps
    let degree = taps[0]
    self.degree = degree
    self.bound = (1 << degree) - 1
  }
  
  static func getNextState(_ state: UInt, taps: [UInt], degree: UInt, bound: UInt) -> UInt {
    var bit: UInt = 0
    for tap in taps { bit ^= (state >> (degree - tap)) }
    return (state >> 1) | ((bit << (degree - 1)) & bound)
  }
  
  static func randomUInt(_ n: UInt) -> UInt {
    guard n > 1 else { return 0 }
    guard n <= UInt32.max else { fatalError("\(n) is out of range.") }
    return UInt(arc4random_uniform(UInt32(n)))
  }
  
  static var maxPeriod: UInt {
    return (1 << (UInt(maximalTapsArray.count) + 1)) - 1
  }
  
  public mutating func next() -> UInt? {
    let previousState = state
    repeat { state = LFSR.getNextState(state, taps: taps, degree: degree, bound: bound) } while state > n
    return previousState - 1
  }
}
