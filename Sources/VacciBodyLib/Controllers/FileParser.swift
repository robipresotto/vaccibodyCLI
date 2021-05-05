//
//  FileParser.swift
//  VacciBodyLib
//
//  Created by Robinson Presotto on 29/04/2021.
//

import Foundation

enum FileParserError: Error {
  case cannotParseString, fileNotFound
}

struct FastaData: Codable {
  let desc: String
  let data: String
}

final class ParserFastaFile {
  
  static func parse(filePath: String) throws -> [FastaData] {
    var result: [FastaData] = []
    if freopen(filePath, "r", stdin) == nil {
      throw FileParserError.fileNotFound
    }
    var desc: String = ""
    var data: String = ""
    while let line = readLine() {
      if line.hasPrefix(">") {
        if desc != "" {
          result.append(
            FastaData(
              desc: desc,
              data: data
            )
          )
          desc = ""
          data = ""
        }
        desc = line
      } else {
        data.append(line)
      }
    }
    result.append(FastaData(desc: desc, data: data))
    return result
  }
  
  static func writeData(data: [MatchesData]) throws -> Void {
    
    // Save data to file
    let fileManager = FileManager.default
    let path = fileManager.currentDirectoryPath
    let filePath = URL(fileURLWithPath: path + "/result.json")
    let json = try JSONEncoder().encode(data)
    guard let dataString = String(data: json, encoding: .utf8) else {
      throw FileParserError.cannotParseString
    }
        
    return try """
    \(dataString)
    """.write (
      to: filePath,
      atomically: false,
      encoding: .utf8
    )
    
  }
  
}
