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
    peptidesFilePath: String,
    proteomeFilePath: String,
    onProgress: @escaping (_ total: Int, _ progress: Int, _ matches: Int) -> Void,
    onComplete: @escaping (_ matches: [MatchesData]) throws -> Void) throws {
    
    var matches: [MatchesData] = []
    var matchesCounter: Int = 0
    var progressCounter: Int = 0
    
    let peptides = try ParserFastaFile.parse(filePath: peptidesFilePath)
    let proteome = try ParserFastaFile.parse(filePath: proteomeFilePath)
        
    let proteomeTotal = peptides.count * proteome.count
    onProgress(proteomeTotal, progressCounter, matchesCounter)
    let _ = proteome.asyncMap { proSec in
      let _ = peptides.asyncMap { pepSec in
        progressCounter+=1
        if proSec.data.contains(pepSec.data) {
          matchesCounter+=1
          onProgress(proteomeTotal, progressCounter, matchesCounter)
          matches.append(
            MatchesData(
              peptide: pepSec,
              proteome: proSec
            )
          )
        }
      }
    }
    onProgress(proteomeTotal, proteomeTotal, matchesCounter)
    try onComplete(matches)
    
  }
  
}
