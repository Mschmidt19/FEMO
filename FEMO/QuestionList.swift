//
//  QuestionList.swift
//  FEMO
//
//  Created by Marek Schmidt on 9/21/18.
//  Copyright © 2018 FEMO@Makers. All rights reserved.
//

import Foundation

class QuestionList {
    var list = [Question]()
    
    init() {
        list.append(Question(questionText: "Question1", choiceA: "String1", choiceB: "String2", choiceC: "String3", choiceD: "String4", answer: 1))
        
        list.append(Question(questionText: "Question2", choiceA: "String5", choiceB: "String6", choiceC: "String7", choiceD: "String8", answer: 2))
        
        list.append(Question(questionText: "Question3", choiceA: "String9", choiceB: "String10", choiceC: "String11", choiceD: "String12", answer: 3))
        
        list.append(Question(questionText: "Question4", choiceA: "String13", choiceB: "String14", choiceC: "String15", choiceD: "String16", answer: 4))
        
        
        list = list.shuffled()
    }
}
