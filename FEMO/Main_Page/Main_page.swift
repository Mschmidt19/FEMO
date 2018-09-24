//
//  Main_page.swift
//  FEMO
//
//  Created by Eunbit Evie Kim on 22/09/2018.
//  Copyright © 2018 FEMO@Makers. All rights reserved.
//

import SpriteKit

class Main_page: SKScene {

    var Space_sceneNode: SKSpriteNode!
    var Desert_sceneNode: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        Space_sceneNode = (self.childNode(withName: "Space_scene") as! SKSpriteNode)
        Desert_sceneNode = (self.childNode(withName: "Desert_scene") as! SKSpriteNode)
        
        Space_sceneNode.texture = SKTexture(imageNamed: "Space_scene")
        Desert_sceneNode.texture = SKTexture(imageNamed: "Desert_scene")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let location = touch?.location(in: self) {
           let node = self.nodes(at: location).first
            if node?.name  == "Space_scene" || node?.name == "SpaceText" {
                let transition = SKTransition.doorsOpenHorizontal(withDuration: 0.5)
                let gameScene = GameScene(fileNamed: "GameScene")
                self.view?.presentScene(gameScene!, transition: transition)
            }
            
//            if node?.name  == "Desert_scene" || node?.name == "DesertText" {
//                let transition = SKTransition.doorsOpenHorizontal(withDuration: 0.5)
//                let gameScene = GameScene(fileNamed: "DesertGameScene")
//                self.view?.presentScene(gameScene!, transition: transition)
//            }
        }
    }
    
}
