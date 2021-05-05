import XCTest
@testable import VacciBodyLib

final class MatcherTests: XCTestCase {
  
  func testMatcher() throws {
    
    let peptides = try ParserFastaFile.parse(filePath: FastaFile.peptidesFilePath)
    let proteome = try ParserFastaFile.parse(filePath: FastaFile.proteomeFilePath)
    
    self.measure {
      do {
        let _ = try Matcher.runAsync(
          peptides: peptides,
          proteome: proteome,
          onProgress: { total, progress, matches in
          print(progress, total, matches)
        }, onComplete: { data in
          print(data)
        })
      } catch {
        
      }
    }
        
  }
  
  func testBoyerMooreSearch() throws {
    
    let peptides = try ParserFastaFile.parse(filePath: FastaFile.peptidesFilePath)
    let proteome = try ParserFastaFile.parse(filePath: FastaFile.proteomeFilePath)

    self.measure {
      var count = 0
      let _ = proteome.asyncMap { pro in
        let _ = peptides.asyncMap { pep in
          if let _ = pro.data.boyerMooreSearch(of: pep.data) {
            count+=1
            print(count, pep, pro)
          }
        }
      }
    }
    
  }
  
  func testBruteForceSearch() throws {
    
    let peptides = try ParserFastaFile.parse(filePath: FastaFile.peptidesFilePath)
    let proteome = try ParserFastaFile.parse(filePath: FastaFile.proteomeFilePath)

    self.measure {
      var count = 0
      let _ = proteome.asyncMap { pro in
        let _ = peptides.asyncMap { pep in
          if let _ = pro.data.bruteForceSearch(pep.data) {
            count+=1
            print(count, pep, pro)
          }
        }
      }
    }
    
  }
  
  func testEntireFileSearch() throws {
    
    let peptides = try ParserFastaFile.parse(filePath: FastaFile.peptidesFilePath)
    let proteome = try String(contentsOfFile: FastaFile.proteomeFilePath)
    
    self.measure {
      var count = 0
      let _ = peptides.map { peptide in
        if proteome.bruteForceSearch(peptide.data) != nil {
          count+=1
          print(count)
        }
      }
    }
    
  }

}
