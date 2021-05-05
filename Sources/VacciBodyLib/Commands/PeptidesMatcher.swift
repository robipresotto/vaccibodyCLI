//
//  ParsableCommand.swift
//  VacciBodyLib
//
//  Created by Robinson Presotto on 30/04/2021.
//

import ArgumentParser

public struct PeptidesMatcher: ParsableCommand {
  
  public init() {}
  public static let configuration = CommandConfiguration(
    commandName: "match",
    abstract: "Scan a list of short peptides against the proteome and returns the matches"
  )

  @Argument(help: "Peptides file path")
  private var peptidesFilePath: String
  
  @Argument(help: "Proteome file path")
  private var proteomeFilePath: String
  
  public func run() throws {
    
    let loading = Loading.init(
      title: "VacciBody CLI"
    )
    
    try Matcher.runAsync(
      peptides: try ParserFastaFile.parse(filePath: peptidesFilePath),
      proteome: try ParserFastaFile.parse(filePath: proteomeFilePath),
      onProgress: { total, progress, matches in
        loading.progress(
          progress: progress,
          total: total,
          matches: matches
        )
      },
      onComplete: { matches in
        loading.done(maches: matches.count)
         try ParserFastaFile.writeData(
          data: matches
        )
      }
    )
    
  }
  
}

