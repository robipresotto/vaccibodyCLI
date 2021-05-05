//
//  String.swift
//  VacciBodyLib
//
//  Created by Robinson Presotto on 05/05/2021.
//

import Foundation

extension String {
  
  // brute force search
  func bruteForceSearch(_ pattern: String) -> Bool {
    for i in indices {
      var j = i
      var found = true
      for p in pattern.indices {
        guard j != endIndex && self[j] == pattern[p] else {
          found = false; break
        }
        j = index(after: j)
      }
      if found {
        return true
      }
    }
    return false
  }
  
  // Boyer-Moore-Horspool algorithm
  func boyerMooreSearch(_ pattern: String) -> Index? {

    let lengthPattern = pattern.count
    guard lengthPattern > 0, lengthPattern <= count else { return nil }

    var skipTable = [Character: Int]()
    for (i, c) in pattern.enumerated() {
      skipTable[c] = lengthPattern - i - 1
    }

    let p = pattern.index(before: pattern.endIndex)
    let lastChar = pattern[p]

    var i = index(startIndex, offsetBy: lengthPattern - 1)

    func backwards() -> Index? {
      var q = p
      var j = i
      while q > pattern.startIndex {
        j = index(before: j)
        q = index(before: q)
        if self[j] != pattern[q] { return nil }
      }
      return j
    }

    while i < endIndex {
      let c = self[i]
      if c == lastChar {
        if let k = backwards() { return k }
        i = index(after: i)
      } else {
        i = index(i, offsetBy: skipTable[c] ?? lengthPattern, limitedBy: endIndex) ?? endIndex
      }
    }
    return nil
  }
  
}

// Bloom Filter
struct BloomFilter<Element: Hashable> {
  private var data: [Bool]
  private let seeds: [Int]
  
  init(size: Int, hashCount: Int) {
    data = Array(repeating: false, count: size)
    seeds = (0..<hashCount).map { _ in Int.random(in: 0..<Int.max) }
  }
  
  private func hashes(for element: Element) -> [Int] {
    return seeds.map { seed -> Int in
      var hasher = Hasher()
      hasher.combine(element)
      hasher.combine(seed)
      let hashValue = abs(hasher.finalize())
      return hashValue
    }
  }
  
  mutating func insert(_ element: Element) {
    hashes(for: element).forEach { hash in
      data[hash % data.count] = true
    }
  }
  
  func contains(_ element: Element) -> Bool {
    return hashes(for: element).allSatisfy { hash in
      data[hash % data.count]
    }
  }
  
}
