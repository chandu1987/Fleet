//
//  FleetWordsTests.swift
//  FleetWordsTests
//
//  Created by Chandra Sekhar Ravi on 24/12/20.
//

import XCTest
@testable import FleetWords

class FleetWordsTests: XCTestCase {
    
    var wordsGenerator : WordsGenerator!

    //setup
    override func setUp() {
        super.setUp()
        wordsGenerator = WordsGenerator()
    }
    
    //teardown
    override func tearDown() {
        wordsGenerator = nil
        super.tearDown()
    }
    
    //test the out come of possible matches
    func testPossibleMatches(){
        let possibleMatches = wordsGenerator.getAllCombinationsOfString(Array("ODG"))
        XCTAssertNotNil(possibleMatches, "Possible matches returned nil")
        XCTAssertEqual(15, possibleMatches.count, "Invalid number of matches")
    }
    
    //test the out come 
    func testTheOutPutForNomalString(){
        let output = wordsGenerator.findCombinations("GO")
        XCTAssertNotNil(output, "output returned nil")
        XCTAssertEqual(2, output.count, "Wrong output returned")
    }
    
    func testTheOutPutForStringWithSpace(){
        let output = wordsGenerator.findCombinations("G O")
        XCTAssertNotNil(output, "output returned nil")
        XCTAssertTrue( output.count == 2, "Wrong output returned")
    }
    
    
    func testTheOutPutForStringWithSingleCharacter(){
        let output = wordsGenerator.findCombinations("G")
        XCTAssertNotNil(output, "output returned nil")
        XCTAssertFalse(output.count != 1, "Wrong output returned")
    }
    

}
