//
//  Matcher.swift
//  VacciBodyLib
//
//  Created by Robinson Presotto on 29/04/2021.
//

import Foundation

struct MatchesData: Codable {
  let peptide: FastaData
  let proteome: FastaData
}

final class Matcher {
  
  static func runAsync(
    peptides: [FastaData],
    proteome: [FastaData],
    onProgress: @escaping (_ total: Int, _ progress: Int, _ matches: Int) -> Void,
    onComplete: @escaping (_ matches: [MatchesData]) throws -> Void) throws {
    
    var matches: [MatchesData] = []
    var matchesCounter: Int = 0
    var progressCounter: Int = 0
    let runSize = peptides.count * proteome.count
    
    let _ = proteome.asyncMap { pro in
      let _ = peptides.asyncMap { pep in
        progressCounter+=1
        if pro.data.contains(pep.data) {
          matches.append(
            MatchesData(
              peptide: pep,
              proteome: pro
            )
          )
          matchesCounter+=1
          onProgress(runSize, progressCounter, matchesCounter)
        }
      }
    }
    try onComplete(matches)
    
  }
  
}
