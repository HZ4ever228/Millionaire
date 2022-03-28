//
//  QuestionSellecterFacade.swift
//  Millionaire
//
//  Created by Anton Hodyna on 28/03/2022.
//

import Foundation

class ActualQuestionFacade {
    let question: Question
    
    //MARK: Construction
    
    init(question: Question) {
        self.question = question
    }
    
    //MARK: - Functions
    
    func fiftyfifty() -> [String] {
        let allAnswers = [question.firstAnswer, question.secondAnswer, question.thirdAnswer, question.fourthAnswer]
        var answers: [String] = []
        for answer in allAnswers {
            if answer == question.correctAnswer {
                answers.append(answer)
            } else if answers.count < 2, answers.contains(where: {$0 == question.correctAnswer}) {
                answers.append(answer)
            } else if answers.count == 0 {
                answers.append(answer)
            }
        }
        return answers
    }
    
    func callToFriend() -> String {
        var friendAnswers = fiftyfifty()
        friendAnswers.append(getIncorrectAnswer())
        
        return friendAnswers.randomElement() ?? "ошибка"
    }
    
    func hallhelp() -> String {
        var hallAnswers = [question.firstAnswer, question.secondAnswer, question.thirdAnswer, question.fourthAnswer]
        for _ in 0...7 {
            hallAnswers.append(question.correctAnswer)
        }
        return hallAnswers.randomElement() ?? "ошибка"
    }
    
    func isAnserRight(userAnswer: String) -> Bool {
        return userAnswer == question.correctAnswer
    }
    
    func getIncorrectAnswer() -> String {
        return "Ало! Ало! Кто это? связь плохая... пшшшшш"
    }
    
}
