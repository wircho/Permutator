//
//  Permutator.swift
//

public struct Permutator<C: Collection>: Sequence where C.Index == Int {
  let collection: C
  
  public init(_ collection: C) {
    self.collection = collection
  }
  
  public __consuming func makeIterator() -> PermutatorIterator<C> {
    return .init(collection)
  }
}
