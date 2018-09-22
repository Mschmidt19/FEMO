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
    
    let userDefaults = UserDefaults.standard
    
    var viewController: GameViewController!
    
    var tilesArray:[SKSpriteNode]? = [SKSpriteNode]()
    var player1:SKSpriteNode?
    
    var currentTile = 0
    var currentTileRow = 1
    var movingToTile = false
    var moveDuration = 0.4
    
    var dieRoll = 0
    
    let moveSound = SKAction.playSoundFileNamed("tap.wav", waitForCompletion: false)
    
    func setupTiles() {
        for i in 1...30 {
            if let tile = self.childNode(withName: "tile\(i)") as? SKSpriteNode {
                tilesArray?.append(tile)
            }
        }
    }
    
    func createPlayer1() {
        player1 = SKSpriteNode(imageNamed: "robot1")
        
        guard let player1PositionX = tilesArray?[currentTile].position.x else {return}
        guard let player1PositionY = tilesArray?[currentTile].position.y else {return}
        player1?.position = CGPoint(x: player1PositionX, y: player1PositionY + 15)
        
        let playerXScale = userDefaults.integer(forKey: "playerXScale")
        if playerXScale != 0 {
            player1?.xScale = CGFloat(playerXScale)
        }
        
        self.addChild(player1!)
    }
    
    override func didMove(to view: SKView) {
        setupTiles()
        
        let savedTile = userDefaults.integer(forKey: "currentTile")
        if savedTile > 0 {
            currentTile = savedTile
        } else {
            currentTile = 0
        }
        
        createPlayer1()
    }
    
    func moveToNextTile() {
        player1?.removeAllActions()
        movingToTile = true
        
        guard let nextTile = tilesArray?[currentTile + 1].position else {return}
        
        if nextTile.x == (tilesArray?[currentTile].position.x)! {
            if currentTileRow % 2 == 1 {
                player1?.xScale = -1.0
            } else {
                player1?.xScale = 1.0
            }
            currentTileRow += 1
        }
        
        if let player1 = self.player1 {
            let moveAction = SKAction.move(to: CGPoint(x: nextTile.x, y: nextTile.y + 15), duration: moveDuration)
            player1.run(moveAction, completion: {
                self.movingToTile = false
            })
            currentTile += 1
            
            self.run(moveSound)
        }
    }
    
    func rollDie() {
        let roll = arc4random_uniform(_:6) + 1
        dieRoll = Int(roll)
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
            } else if node?.name == "showPopupButton" {
//                let sb = UIStoryboard(name: "QuestionPopupViewController", bundle: nil)
//                if let popup = sb.instantiateInitialViewController() {
//                    self.viewController.present(popup, animated: true)
//                }
                saveGameState()
                let transition = SKTransition.reveal(with: .up, duration: 0.5)
                let questionScene = GameScene(fileNamed: "QuestionScene")
                self.view?.presentScene(questionScene!, transition: transition)
            } else if node?.name == "resetDefaults" {
                resetGameState()
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
    
    func resetGameState() {
        print("resetting game state")
        let bundleIdentifier = Bundle.main.bundleIdentifier!
        userDefaults.removePersistentDomain(forName: bundleIdentifier)
    }
    
    func saveGameState() {
        userDefaults.set(currentTile, forKey: "currentTile")
        userDefaults.set(player1?.xScale, forKey: "playerXScale")
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return userDefaults.object(forKey: key) != nil
    }
}
