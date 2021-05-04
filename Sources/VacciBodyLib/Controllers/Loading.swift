//
//  Loading.swift
//  VacciBodyLib
//
//  Created by Robinson Presotto on 01/05/2021.
//

import TSCBasic
import TSCUtility
import Foundation

final class Loading {
  
  let animation: PercentProgressAnimation
  let startTime: Date = Date()
  
  init(title: String) {
    print("\n")
    self.animation = PercentProgressAnimation(
      stream: stdoutStream,
      header: "\(title)"
    )
  }
  
  func progress(progress: Int, total: Int, matches: Int) {
    self.animation.update(
      step: progress,
      total: total,
      text: ""
    )
  }
  
  func done(maches: Int) {
    
    animation.complete(
      success: true
    )
            
    print("""
    |
    | Matches: \(maches)
    | Time Elapsed: \(Int(Date().timeIntervalSince(startTime)))s
    |

    """)
    
  }
  
}
