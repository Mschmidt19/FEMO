//
//  QuestionViewController.swift
//  FEMO
//
//  Created by Marek Schmidt on 9/21/18.
//  Copyright © 2018 FEMO@Makers. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    let gameViewController: GameViewController = GameViewController(nibName: nil, bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updateQuestion()
    }
    
    @IBAction func answerPressed(_ sender: UIButton) {
        if sender.tag == gameViewController.correctAnswer {
            print("correct")
        } else {
            print("incorrect")
        }
        
        dismiss(animated: true)
    }
    
    func updateQuestion() {
        
        print(gameViewController.allQuestions.list.count)
        for i in 0...gameViewController.allQuestions.list.count-1 {
            print(gameViewController.allQuestions.list[i].question)
        }
        
        questionLabel.text = self.gameViewController.allQuestions.list[self.gameViewController.questionNumber].question
    button1.setTitle(self.gameViewController.allQuestions.list[self.gameViewController.questionNumber].optionA, for: UIControlState.normal)
    button2.setTitle(self.gameViewController.allQuestions.list[self.gameViewController.questionNumber].optionB, for: UIControlState.normal)
    button3.setTitle(self.gameViewController.allQuestions.list[self.gameViewController.questionNumber].optionC, for: UIControlState.normal)
    button4.setTitle(self.gameViewController.allQuestions.list[self.gameViewController.questionNumber].optionD, for: UIControlState.normal)
        
        gameViewController.correctAnswer = self.gameViewController.allQuestions.list[self.gameViewController.questionNumber].correctAnswer
        
    }
    
    func updateQuestionUI() {
        
    }
    
}
