//
//  QuestionScene.swift
//  FEMO
//
//  Created by Marek Schmidt on 9/22/18.
//  Copyright © 2018 FEMO@Makers. All rights reserved.
//

import SpriteKit

class QuestionScene: SKScene {
    
    let userDefaults = UserDefaults.standard
    
    var questionList = [Question]()
    var currentQuestion = 0
    
    var starField: SKEmitterNode!
    
    var questionText: SKLabelNode!
    var button1Text: SKLabelNode!
    var button2Text: SKLabelNode!
    var button3Text: SKLabelNode!
    var button4Text: SKLabelNode!
    var button1Background: SKSpriteNode!
    var button2Background: SKSpriteNode!
    var button3Background: SKSpriteNode!
    var button4Background: SKSpriteNode!
    
    let buttonNames = ["button1Text", "button1Background", "button2Text", "button2Background", "button3Text", "button3Background", "button4Text", "button4Background"]
    
    override func didMove(to view: SKView) {
        
        starField = (self.childNode(withName: "starField") as! SKEmitterNode)
        starField.advanceSimulationTime(14)

        
        questionText = (self.childNode(withName: "questionText") as! SKLabelNode)
        button1Text = (self.childNode(withName: "button1Text") as! SKLabelNode)
        button2Text = (self.childNode(withName: "button2Text") as! SKLabelNode)
        button3Text = (self.childNode(withName: "button3Text") as! SKLabelNode)
        button4Text = (self.childNode(withName: "button4Text") as! SKLabelNode)
        button1Background = (self.childNode(withName: "button1Background") as! SKSpriteNode)
        button2Background = (self.childNode(withName: "button2Background") as! SKSpriteNode)
        button3Background = (self.childNode(withName: "button3Background") as! SKSpriteNode)
        button4Background = (self.childNode(withName: "button4Background") as! SKSpriteNode)
        
        let questionClass = QuestionList()
        let questionListFromClass = questionClass.list
        let questionListFromDefaults = userDefaults.array(forKey: "questionList")
        if isKeyPresentInUserDefaults(key: "questionList") {
            questionList = questionListFromDefaults as! [Question]
        } else {
            questionList = questionListFromClass
        }
        
        if isKeyPresentInUserDefaults(key: "currentQuestion") {
            currentQuestion = userDefaults.integer(forKey: "currentQuestion")
        } else {
            currentQuestion = 0
        }
        
        let questionCount = questionList.count
        
//        print(currentQuestion)
//        for i in 0...questionCount-1 {
//            print(questionList[i].question)
//        }
        
        questionText.text = questionList[currentQuestion % questionCount].question
        button1Text.text = questionList[currentQuestion % questionCount].optionA
        button2Text.text = questionList[currentQuestion % questionCount].optionB
        button3Text.text = questionList[currentQuestion % questionCount].optionC
        button4Text.text = questionList[currentQuestion % questionCount].optionD
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            if let node = self.nodes(at: location).first {
                if buttonNames.contains(node.name!) {
                    answerButtonPressed(node: node)
                }
            }
        }
        
    }
    
    func presentSpaceBoard() {
        let transition = SKTransition.reveal(with: .up, duration: 0.5)
        
        let spaceGameScene = GameScene(fileNamed: "GameScene")
        self.view?.presentScene(spaceGameScene!, transition: transition)
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return userDefaults.object(forKey: key) != nil
    }
    
    func saveGameState() {
//        userDefaults.set(questionList, forKey: "questionList")
        userDefaults.set(currentQuestion, forKey: "currentQuestion")
    }
    
    func answerButtonPressed(node: SKNode) {
        let questionCount = questionList.count
        let tag = ((node.userData!.object(forKey: "tag")!) as! Int)
        if tag == questionList[currentQuestion % questionCount].correctAnswer {
            userDefaults.set(true, forKey: "lastAnswerCorrect")
        } else {
            userDefaults.set(false, forKey: "lastAnswerCorrect")
        }
        currentQuestion += 1
        saveGameState()
        presentSpaceBoard()
    }

}
