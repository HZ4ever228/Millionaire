//
//  GameViewController.swift
//  Millionaire
//
//  Created by Anton Hodyna on 22/03/2022.
//

import UIKit

class GameViewController: UIViewController {
    
    let game = Game.shared
    var delegate: LastGameResultProtocol?
    
    @IBOutlet weak var fiftyFiftyButton: UIButton!
    @IBOutlet weak var callToFriendButton: UIButton!
    @IBOutlet weak var hallHelpButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var firstAnwerButton: UIButton!
    @IBOutlet weak var secondAnswerButton: UIButton!
    @IBOutlet weak var thirdAnswerButton: UIButton!
    @IBOutlet weak var fourthAnswerButton: UIButton!
    @IBOutlet weak var callToFriendView: UIView!
    @IBOutlet weak var callToFriendLabel: UILabel!
    
    private var gameSession: GameSession? = GameSession()
    private var timerCallToFriend: Timer?
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureActualQuestion()
        gameSession?.name = game.name ?? ""
        game.gameSession = gameSession
    }
    
    //MARK: - Actions
    
    @IBAction func exitButtonAction(_ sender: Any) {
        
        dismiss(animated: true, completion: {
            self.game.addRecord(record: Record(score: self.gameSession?.score, name: self.gameSession?.name))
            self.delegate?.returnLastGameResult(gameSession: self.gameSession)
            self.gameSession = nil
        })
    }
    
    @IBAction func firstAnswerButtonAction(_ sender: Any) {
        isAnswerRigth(button: firstAnwerButton)
    }
    @IBAction func secondAnswerButtonAction(_ sender: Any) {
        isAnswerRigth(button: secondAnswerButton)
    }
    @IBAction func thirdAnswerButtonAction(_ sender: Any) {
        isAnswerRigth(button: thirdAnswerButton)
    }
    @IBAction func fourthAnswerButtonAction(_ sender: Any) {
        isAnswerRigth(button: fourthAnswerButton)
    }
    
    @IBAction func fiftyFiftyButtonAction(_ sender: Any) {
        guard let actualQuestion = gameSession?.question else { return }
        configureGameForFiftyFifty(answers: actualQuestion.fiftyfifty())
        gameSession?.isFiftyFifty = false
        gameSession?.helpsCount -= 1
    }
    
    @IBAction func callToFriendButtonAction(_ sender: Any) {
        callTofriend()
        gameSession?.isFriendCall = false
        gameSession?.helpsCount -= 1
    }
    @IBAction func hallHelpButtonAction(_ sender: Any) {
        hallHelp()
        gameSession?.isHallHelp = false
        gameSession?.helpsCount -= 1
    }
    
    
    private func configureActualQuestion() {
        guard let score = gameSession?.score else { return }
        
        switch score {
        case 0:
            gameSession?.question = QuestionsEnum.firstQuestion.question
        case 10:
            gameSession?.question = QuestionsEnum.secondQuestion.question
        case 20:
            gameSession?.question = QuestionsEnum.thirdQuestion.question
        case 30:
            gameSession?.question = QuestionsEnum.fourthQuestion.question
        case 40:
            gameSession?.question = QuestionsEnum.fifthQuestion.question
        default:
            break
        }
        configureGame()
    }
    
    private func configureGame() {
        guard let gameSession = gameSession, let question = gameSession.question else { return }
        scoreLabel.text = "счет: \(gameSession.score)"
        
        if !callToFriendView.isHidden {
            callToFriendView.isHidden = true
        }
        
        callToFriendButton.isHidden = !gameSession.isFriendCall
        fiftyFiftyButton.isHidden = !gameSession.isFiftyFifty
        hallHelpButton.isHidden = !gameSession.isHallHelp

        unhideAndUncolorUnswerButtons()
        questionLabel.text = question.question
        firstAnwerButton.setTitle(question.firstAnswer, for: .normal)
        secondAnswerButton.setTitle(question.secondAnswer, for: .normal)
        thirdAnswerButton.setTitle(question.thirdAnswer, for: .normal)
        fourthAnswerButton.setTitle(question.fourthAnswer, for: .normal)
    }
    
    private func isAnswerRigth(button: UIButton) {
        if let answer = button.titleLabel?.text, let question = gameSession?.question {
            if question.isAnserRight(userAnswer: answer) {
                gameSession?.score += 10
                configureActualQuestion()
            } else {
                dismiss(animated: true, completion: {
                    self.game.addRecord(record: Record(score: self.gameSession?.score, name: self.gameSession?.name))
                    self.delegate?.returnLastGameResult(gameSession: self.gameSession)
                    self.gameSession = nil
                })
            }
        }
    }
    
    private func configureGameForFiftyFifty(answers: [String]) {
        if !isButtonWithSomeOfTheAnswers(answers: answers, button: firstAnwerButton) {
            firstAnwerButton.isHidden = true
        }
        if !isButtonWithSomeOfTheAnswers(answers: answers, button: secondAnswerButton) {
            secondAnswerButton.isHidden = true
        }
        if !isButtonWithSomeOfTheAnswers(answers: answers, button: thirdAnswerButton) {
            thirdAnswerButton.isHidden = true
        }
        if !isButtonWithSomeOfTheAnswers(answers: answers, button: fourthAnswerButton) {
            fourthAnswerButton.isHidden = true
        }
    }
    
    private func isButtonWithSomeOfTheAnswers(answers: [String], button: UIButton) -> Bool {
        for answer in answers {
            if isButtonWithAnswer(button: button, answer: answer) {
                return true
            }
        }
        return false
    }
    
    private func isButtonWithAnswer(button: UIButton, answer: String) -> Bool {
        if button.titleLabel?.text == answer {
            return true
        } else {
            return false
        }
    }
    
    private func unhideAndUncolorUnswerButtons() {
        firstAnwerButton.isHidden = false
        firstAnwerButton.layer.backgroundColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0)
        secondAnswerButton.isHidden = false
        secondAnswerButton.layer.backgroundColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0)
        thirdAnswerButton.isHidden = false
        thirdAnswerButton.layer.backgroundColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0)
        fourthAnswerButton.isHidden = false
        fourthAnswerButton.layer.backgroundColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0)
    }
    
    private func callTofriend() {
        timerCallToFriend = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
            self.callToFriendView.isHidden = false
            self.callToFriendLabel.text = "Звоним другу..."
            self.timerCallToFriend = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
                if let answer = self.gameSession?.question?.callToFriend() {
                    if answer != self.gameSession?.question?.incorectAnswer {
                        self.callToFriendLabel.text = "Я думаю, что это \(answer)"
                    } else {
                        self.callToFriendLabel.text = answer
                    }
                } else {
                    print("ошибка callTofriend()")
                }
            }
        }
    }
    
    private func hallHelp() {
        guard let actualQuestion = gameSession?.question else { return }
        let hallAnswer = actualQuestion.hallhelp()
        timerCallToFriend = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
            if self.isButtonWithAnswer(button: self.firstAnwerButton, answer: hallAnswer) {
                self.firstAnwerButton.layer.backgroundColor = CGColor(red: 0, green: 1, blue: 0, alpha: 0.5)
            }
            if self.isButtonWithAnswer(button: self.secondAnswerButton, answer: hallAnswer) {
                self.secondAnswerButton.layer.backgroundColor = CGColor(red: 0, green: 1, blue: 0, alpha: 0.5)
            }
            if self.isButtonWithAnswer(button: self.thirdAnswerButton, answer: hallAnswer) {
                self.thirdAnswerButton.layer.backgroundColor = CGColor(red: 0, green: 1, blue: 0, alpha: 0.5)
            }
            if self.isButtonWithAnswer(button: self.fourthAnswerButton, answer: hallAnswer) {
                self.fourthAnswerButton.layer.backgroundColor = CGColor(red: 0, green: 1, blue: 0, alpha: 0.5)
            }
        }
    }
    
}

//MARK: - Extensions

protocol LastGameResultProtocol {
    func returnLastGameResult(gameSession: GameSession?)
}
