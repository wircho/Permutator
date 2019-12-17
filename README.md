# Permutator

A small package to generate (pseudo-)random (lazy) permutations, preferably of large numbers or collections.

## Usage

### `Permutation(n)`

If `n` is an `UInt`, then `Permutation(n)` is a (lazy) sequence representing a random permutation of the numbers between `0` and `n - 1`.

### `Permutator([...])`

If `c` is a `Collection`, then `Permutator(c)` is a sequence representing a random permutation of `c`'s elements.

### `PermutationIterator` and `PermutatorIterator` 

`PermutationIterator` and `PermutatorIterator` are the iterators created by the two `Sequence` types above, respectively. You can also manually initialize them, and use their `next()` method to generate new values.

`PermutationIterator` is also `Codable` (and very light). So you could, for example, persist its current state and continue generating values of a permutation at a later time.

### Theory

All of the types above use a `PermutationIterator` internally. `PermutatorIterator` uses a maximal linear-feedback shift register (LSFR) whose period is a larger number than the initializing parameter `n`. The maximal length polynomials used are hard-coded in `LSFR.swift`. Pseudo-randomly, LSFR numbers are also shifted by a phase between `0` and `n - 1`, and/or "flipped" by applying `{ n - 1 - $0 }`.

This means the number of possibly generated permutations is less than or equal to `2 * n * n` (normally far smaller than `n!`). However for large values of `n`, in most applications, it is unlikely to obtain the same permutation twice.

The most useful application of this package is to produce non-trivial permutations of large numbers without using a lot of memory or large lookup tables.
