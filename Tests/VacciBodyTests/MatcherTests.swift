import XCTest
@testable import VacciBodyLib

final class MatcherTests: XCTestCase {
  
  func testPeptidesAsyncMatcher() throws {
    
    self.measure {
      do {
        let _ = try Matcher.runAsync(
          peptidesFilePath: FastaFile.peptidesFilePath,
          proteomeFilePath: FastaFile.proteomeFilePath,
          onProgress: { total, progress, matches in
            print("\(progress) of \(total) - matches: \(matches)")
          }, onComplete: { matches in
            print(matches)
        })
      } catch {
        XCTAssertThrowsError(error)
      }
    }
    
  }

}
