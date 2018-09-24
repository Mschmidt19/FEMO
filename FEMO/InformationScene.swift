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

    
    override func didMove(to view: SKView) {
        InformationNode = self.childNode(withName: "Information_button") as! SKSpriteNode
        InformationNode.texture = SKTexture(imageNamed: "green_alien")
    }
        
}
