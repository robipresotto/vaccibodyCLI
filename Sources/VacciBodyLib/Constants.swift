//
//  Constants.swift
//  VacciBodyLib
//
//  Created by Robinson Presotto on 02/05/2021.
//

import Foundation

struct FastaFile {
  static let peptidesFilePath = ProcessInfo.processInfo.environment["PEPTIDES_FILE_PATH"] ?? ""
  static let proteomeFilePath = ProcessInfo.processInfo.environment["PROTEOME_FILE_PATH"] ?? ""
}
