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
    var menu_buttonNode:SKSpriteNode?
    var InformationNode:SKSpriteNode?
    
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
        let menu_buttonNode = self.childNode(withName: "Menu_button") as! SKSpriteNode
        menu_buttonNode.texture = SKTexture(imageNamed: "menu_button")
        
        let InformationNode = self.childNode(withName: "Information_button") as! SKSpriteNode
        InformationNode.texture = SKTexture(imageNamed: "information_button")
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
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            let node = self.nodes(at: location)
            
            if node.first?.name == "nextTileButton" {
                playTurn()
            } else if node.first?.name == "Menu_button" {
                let transition = SKTransition.doorsCloseHorizontal(withDuration: 0.5)
                let menuPage = Main_page(fileNamed: "Main_page")
                self.view?.presentScene(menuPage!, transition: transition)
            } else if node.first?.name == "Information_button" {
                let transition = SKTransition.doorsCloseHorizontal(withDuration: 0.5)
                let information = InformationScene(fileNamed: "Information")
                self.view?.presentScene(information!, transition: transition)
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
