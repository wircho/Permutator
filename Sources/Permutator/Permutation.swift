//
//  Permutation.swift
//

public struct Permutation: Sequence {
  let n: UInt
  
  public init(_ n: UInt) {
    self.n = n
  }
  
  public __consuming func makeIterator() -> PermutationIterator {
    return .init(n)
  }
}
