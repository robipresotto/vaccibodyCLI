//
//  Array.swift
//  VacciBodyLib
//
//  Created by Robinson Presotto on 30/04/2021.
//

import Foundation

public final class ThreadSafe<A> {
  var _value: A
  let queue = DispatchQueue(label: "ThreadSafe")
  init(_ value: A) { self._value = value }

  var value: A {
    return queue.sync { _value }
  }
  func atomically(_ transform: (inout A) -> ()) {
    queue.sync { transform(&self._value) }
  }
}

extension Array {
  
  func asyncMap<M>(threads: Int? = nil, _ transform: (Element) -> M) -> [M] {
    let result = ThreadSafe(Array<M?>(repeating: nil, count: count))
    let nt = threads ?? count
    let cs = (count-1)/nt+1
    DispatchQueue.concurrentPerform(iterations: nt) { i in
      let min = i*cs
      let max = min+cs>count ? count : min+cs
      for idx in (min..<max) {
        let element = self[idx]
        let transformed = transform(element)
        result.atomically { $0[idx] = transformed }
      }
    }
    return result.value.map { $0! }
  }
  
}
