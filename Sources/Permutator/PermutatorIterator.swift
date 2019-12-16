//
//  PermutatorIterator.swift
//

public struct PermutatorIterator<C: Collection>: IteratorProtocol where C.Index == Int {
  let collection: C
  var permutationIterator: PermutationIterator
  
  public init(_ collection: C) {
    self.collection = collection
    self.permutationIterator = PermutationIterator(UInt(collection.count))
  }
  
  public mutating func next() -> C.Element? {
    guard let nextIndex = permutationIterator.next() else { return nil }
    return collection[Int(nextIndex)]
  }
}
