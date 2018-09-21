//
//  GameScene.swift
//  Indiana Codes
//
//  Created by Marek Schmidt on 9/19/18.
//  Copyright © 2018 Marek Schmidt. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var tilesArray:[SKSpriteNode]? = [SKSpriteNode]()
    var player1:SKSpriteNode?
    
    var currentTile = 0
    var movingToTile = false
    var moveDuration = 0.4
    var indexOfLastTile = 0
    var arrsize: Int{
        get {
            return tilesArray!.count
        }
    }
    
    var dieRoll = 0
    
    let moveSound = SKAction.playSoundFileNamed("tap.wav", waitForCompletion: false)
    
    
    func setupTiles() {
        for i in 1...100 {
            if let tile = self.childNode(withName: "tile\(i)") as? SKSpriteNode {
                tilesArray?.append(tile)
            }
        }
//        let a = tilesArray!.count
//        print(a)
    }
    
    func createPlayer1() {
        player1 = SKSpriteNode(imageNamed: "robot1")
        
        guard let player1PositionX = tilesArray?.first?.position.x else {return}
        guard let player1PositionY = tilesArray?.first?.position.y else {return}
        player1?.position = CGPoint(x: player1PositionX, y: player1PositionY + 15)
        
        self.addChild(player1!)
    }
    
    override func didMove(to view: SKView) {
        setupTiles()
        createPlayer1()
        indexOfLastTile = (tilesArray?.index{$0 === tilesArray?.last})!
    }
    
    func moveToNextTile() {
        player1?.removeAllActions()
        movingToTile = true
        
        guard let nextTile = tilesArray?[currentTile + 1] else {return}
        
        if nextTile == self.childNode(withName: "tile7") {
            player1?.xScale = -1.0
        }
        if nextTile == self.childNode(withName: "tile16") {
            player1?.xScale = 1.0
        }
        
        if let player1 = self.player1 {
            let moveAction = SKAction.move(to: CGPoint(x: nextTile.position.x, y: nextTile.position.y + 15), duration: moveDuration)
            player1.run(moveAction, completion: {
                self.movingToTile = false
            })
            currentTile += 1
            
            self.run(moveSound)
        }
    }
    
    func rollDie() {
        let roll = arc4random_uniform(_:6) + 1
        if indexOfLastTile - currentTile < roll {
            dieRoll = Int(indexOfLastTile - currentTile)
        } else {
        dieRoll = Int(roll)
        }
    }
    
    
    func playTurn() {
        rollDie()
        print("You rolled \(dieRoll)")
        var delayAdder = moveDuration
        for _ in 1 ... dieRoll {
            DispatchQueue.main.asyncAfter(deadline: .now() + delayAdder) {
                self.moveToNextTile()
            }
            delayAdder += moveDuration
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.previousLocation(in: self)
            let node = self.nodes(at: location).first
            
            if node?.name == "nextTileButton" {
                playTurn()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !movingToTile {
            player1?.removeAllActions()
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !movingToTile {
            player1?.removeAllActions()
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
