//
//  GameScene.swift
//  FEMOTests
//
//  Created by Farah Jabri on 21/09/2018.
//  Copyright © 2018 FEMO@Makers. All rights reserved.
//


import XCTest
@testable import FEMO

class GameScene: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        // 
    }
    
    func testsetupTiles() {
        
        // setupTiles(), array.count is equal to the number of functional tiles
        
        
//        XCTAssertEqual(Equatable, <#T##expression2: Equatable##Equatable#>)
    }
    
    func testcreatePlayer1() {
         // createPlayer1(), check if player1 is at given position
    }
    
    func testdidMove() {
         // didMove(), is calling 2 functions setupTiles and createPlayer1
    }
    
    func testmoveToNextTile() {
        // moveToNextTile(), moves the player by 1 tile && changes the ‘scale’  from 1 to -1
    }
    
    func testrollDie() {
         // rollDie(), random number between 1 and 6 && mock the rolldie to be 1 for the last tile
        // if 7 tiles away roll will always be the number of roll, if 1 tile away the rolldie will always be 1
    }
    
    func testplayTurn() {
        // playTurn(), delays the functionality of moveToNextTile() by 0.4
    }
}
