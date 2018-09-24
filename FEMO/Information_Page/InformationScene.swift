//
//  InformationScene.swift
//  FEMO
//
//  Created by Eunbit Evie Kim on 22/09/2018.
//  Copyright © 2018 FEMO@Makers. All rights reserved.
//

import SpriteKit

class InformationScene: SKScene {
    
    var InformationNode: SKSpriteNode!
    var menu_buttonNode: SKSpriteNode!
    var play_buttonNode: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        InformationNode = (self.childNode(withName: "Information_button") as! SKSpriteNode)
        InformationNode.texture = SKTexture(imageNamed: "green_alien")
        
        let menu_buttonNode = self.childNode(withName: "Menu_button") as! SKSpriteNode
        menu_buttonNode.texture = SKTexture(imageNamed: "menu_button")
        
        let play_buttonNode = self.childNode(withName: "Play_button") as! SKSpriteNode
        play_buttonNode.texture = SKTexture(imageNamed: "playButton")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            let node = self.nodes(at: location)
            
          if node.first?.name == "Menu_button" {
                let transition = SKTransition.doorsCloseHorizontal(withDuration: 0.5)
                let menuPage = Main_page(fileNamed: "Main_page")
                self.view?.presentScene(menuPage!, transition: transition)
          } else if node.first?.name  == "Play_button" {
                let transition = SKTransition.doorsOpenHorizontal(withDuration: 0.5)
                let gameScene = GameScene(fileNamed: "GameScene")
                self.view?.presentScene(gameScene!, transition: transition)
            }
        }
    }
}
