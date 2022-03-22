//
//  Question.swift
//  Millionaire
//
//  Created by Anton Hodyna on 22/03/2022.
//

import Foundation

struct Question {
    let question: String
    let firstAnswer: String
    let secondAnswer: String
    let thirdAnswer: String
    let fourthAnswer: String
    let correctAnswer: String
    let incorectAnswer = "Ало! Ало! Кто это? связь плохая... пшшшшш"
    
    func fiftyfifty() -> [String] {
        let allAnswers = [firstAnswer, secondAnswer, thirdAnswer, fourthAnswer]
        var answers: [String] = []
        for answer in allAnswers {
            if answer == correctAnswer {
                answers.append(answer)
            } else if answers.count < 2, answers.contains(where: {$0 == correctAnswer}) {
                answers.append(answer)
            } else if answers.count == 0 {
                answers.append(answer)
            }
        }
        return answers
    }
    
    func callToFriend() -> String {
        var friendAnswers = fiftyfifty()
        friendAnswers.append(incorectAnswer)
        
        return friendAnswers.randomElement() ?? "ошибка"
    }
    
    func hallhelp() -> String {
        let hallAnswers = [correctAnswer, firstAnswer, correctAnswer, secondAnswer, correctAnswer, thirdAnswer, correctAnswer, fourthAnswer]
        return hallAnswers.randomElement() ?? "ошибка"
    }
    
    func isAnserRight(userAnswer: String) -> Bool {
        return userAnswer == correctAnswer
    }
    
}

enum QuestionsEnum {
    
    case firstQuestion
    case secondQuestion
    case thirdQuestion
    case fourthQuestion
    case fifthQuestion
    
    var question: Question {
        switch self {
        case .firstQuestion:
            return Question(question: "Кто убежал от дедушки и от бабушки?", firstAnswer: "Колобок", secondAnswer: "Рогалик", thirdAnswer: "Бублик", fourthAnswer: "Пирожок", correctAnswer: "Колобок")
        case .secondQuestion:
            return Question(question: "Столица канады?", firstAnswer: "Монреаль", secondAnswer: "Торонто", thirdAnswer: "Оттава", fourthAnswer: "Канада", correctAnswer: "Оттава")
        case .thirdQuestion:
            return Question(question: "Висит груша - нельзя скушать?", firstAnswer: "Груша", secondAnswer: "Яблоко", thirdAnswer: "Подушка", fourthAnswer: "Лампочка", correctAnswer: "Лампочка")
        case .fourthQuestion:
            return Question(question: "Как звали главного героя фильма 'Матрица'?", firstAnswer: "Нео", secondAnswer: "Нивеа", thirdAnswer: "Нива", fourthAnswer: "Нина", correctAnswer: "Нео")
        case .fifthQuestion:
            return Question(question: "Что дает корова?", firstAnswer: "Пепси", secondAnswer: "Молоко", thirdAnswer: "Виски", fourthAnswer: "Чай", correctAnswer: "Молоко")
        }
    }
    
}
