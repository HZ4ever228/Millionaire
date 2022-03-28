//
//  Question.swift
//  Millionaire
//
//  Created by Anton Hodyna on 22/03/2022.
//

import Foundation

struct Question: Codable {
    let question: String
    let firstAnswer: String
    let secondAnswer: String
    let thirdAnswer: String
    let fourthAnswer: String
    let correctAnswer: String
}

class DefaultQuestions {
    let firstQuestion = Question(question: "Кто убежал от дедушки и от бабушки?", firstAnswer: "Колобок", secondAnswer: "Рогалик", thirdAnswer: "Бублик", fourthAnswer: "Пирожок", correctAnswer: "Колобок")
    let secondQuestion = Question(question: "Столица канады?", firstAnswer: "Монреаль", secondAnswer: "Торонто", thirdAnswer: "Оттава", fourthAnswer: "Канада", correctAnswer: "Оттава")
    let thirdQuestion = Question(question: "Висит груша - нельзя скушать?", firstAnswer: "Груша", secondAnswer: "Яблоко", thirdAnswer: "Подушка", fourthAnswer: "Лампочка", correctAnswer: "Лампочка")
    let fourthQuestion = Question(question: "Как звали главного героя фильма 'Матрица'?", firstAnswer: "Нео", secondAnswer: "Нивеа", thirdAnswer: "Нива", fourthAnswer: "Нина", correctAnswer: "Нео")
    let fifthQuestion = Question(question: "Что дает корова?", firstAnswer: "Пепси", secondAnswer: "Молоко", thirdAnswer: "Виски", fourthAnswer: "Чай", correctAnswer: "Молоко")
}
