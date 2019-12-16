//
//  PermutationIterator.swift
//

public struct PermutationIterator: IteratorProtocol, Codable {
  let n: UInt
  let phase: UInt
  let flip: Bool
  var i: UInt
  var lfsr: LFSR
  
  public init(_ n: UInt) {
    self.n = n
    self.phase = LFSR.randomUInt(n)
    self.flip = LFSR.randomUInt(2) > 0
    self.i = 0
    let mMin = n
    let mMax = min(n * 8 + 1, LFSR.maxPeriod)
    let m = mMin + LFSR.randomUInt(mMax - mMin + 1)
    self.lfsr = LFSR(m)
  }
  
  public mutating func next() -> UInt? {
    guard i < n else { return nil }
    i += 1
    var next: UInt
    repeat { next = lfsr.next()! } while next >= n
    let result = (next + phase) % n
    return flip ? (n - 1 - result) : result
  }
}

