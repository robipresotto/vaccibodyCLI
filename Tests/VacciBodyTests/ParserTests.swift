//
//  ParserTests.swift
//  VacciBodyTests
//
//  Created by Robinson Presotto on 02/05/2021.
//

import XCTest
@testable import VacciBodyLib

final class FastaParserTests: XCTestCase {
  
  func testProteomeFileParser() throws {
    
    self.measure {
      do {
        let _ = try ParserFastaFile.parse(
          filePath: FastaFile.proteomeFilePath
        )
      } catch {
        XCTAssertThrowsError(error)
      }
    }
    
  }
  
  func testPeptideFileParser() throws {
        
    self.measure {
      do {
        let _ = try ParserFastaFile.parse(
          filePath: FastaFile.peptidesFilePath
        )
      } catch {
        XCTAssertThrowsError(error)
      }
    }
    
  }
  
}

