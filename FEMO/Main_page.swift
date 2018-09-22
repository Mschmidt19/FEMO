//
//  Main_page.swift
//  FEMO
//
//  Created by Eunbit Evie Kim on 22/09/2018.
//  Copyright © 2018 FEMO@Makers. All rights reserved.
//

import SpriteKit

class Main_page: SKScene {

    var Space_scene: SKSpriteNode!
    var Desert_scene: SKSpriteNode!
    
    override func didMove(to view: SKView) {
       Space_scene = self.childNode(withName: "Space_scene") as! SKSpriteNode
       Desert_scene = self.childNode(withName: "Desert_scene") as! SKSpriteNode
    }
}
