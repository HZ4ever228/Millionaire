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
    @IBOutlet weak var currentPersentLabel: UILabel!
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
        configureLaunching()
    }
    
    //MARK: - Actions
    
    @IBAction func exitButtonAction(_ sender: Any) {
        endGame()
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
        guard let answers = gameSession?.actualQuestionFacade?.fiftyfifty() else { return }
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
        gameSession?.isFiftyFifty = false
        gameSession?.helpsCount -= 1
    }
    
    @IBAction func callToFriendButtonAction(_ sender: Any) {
        timerCallToFriend = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
            self.callToFriendView.isHidden = false
            self.callToFriendLabel.text = "Звоним другу..."
            self.timerCallToFriend = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
                if let answer = self.gameSession?.actualQuestionFacade?.callToFriend() {
                    if answer != self.gameSession?.actualQuestionFacade?.getIncorrectAnswer() {
                        self.callToFriendLabel.text = "Я думаю, что это \(answer)"
                    } else {
                        self.callToFriendLabel.text = answer
                    }
                    self.gameSession?.isFriendCall = false
                    self.gameSession?.helpsCount -= 1
                }
            }
        }
        
    }
    @IBAction func hallHelpButtonAction(_ sender: Any) {
        guard let hallAnswer = gameSession?.actualQuestionFacade?.hallhelp() else { return }
        timerCallToFriend = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
            if self.isButtonWithAnswer(button: self.firstAnwerButton, answer: hallAnswer) {
                self.firstAnwerButton.layer.backgroundColor = CGColor(red: 0, green: 1, blue: 0, alpha: 0.5)
            } else if self.isButtonWithAnswer(button: self.secondAnswerButton, answer: hallAnswer) {
                self.secondAnswerButton.layer.backgroundColor = CGColor(red: 0, green: 1, blue: 0, alpha: 0.5)
            } else if self.isButtonWithAnswer(button: self.thirdAnswerButton, answer: hallAnswer) {
                self.thirdAnswerButton.layer.backgroundColor = CGColor(red: 0, green: 1, blue: 0, alpha: 0.5)
            } else if self.isButtonWithAnswer(button: self.fourthAnswerButton, answer: hallAnswer) {
                self.fourthAnswerButton.layer.backgroundColor = CGColor(red: 0, green: 1, blue: 0, alpha: 0.5)
            }
            self.gameSession?.isHallHelp = false
            self.gameSession?.helpsCount -= 1
        }
    }
    
    private func configureLaunching() {
        game.gameSession = gameSession
        gameSession?.name = game.name
        gameSession?.firstConfigure(questionsStrategy: game.questionsStrategy)
        
        gameSession?.score.addObserver(self, options: [.new, .initial], closure: { [weak self] (score, _) in
            self?.scoreLabel.text = "Cчет: \(score)"
        })
        
        gameSession?.currentPersent.addObserver(self, options: [.new, .initial], closure: { [weak self] (currentPersent, _) in
            self?.currentPersentLabel.text = "Всего: \(currentPersent)% "
        })
        

        configureActualQuestionOrEndGame()
        
    }
    
    private func configureActualQuestionOrEndGame() {
        if let questions = gameSession?.questions, !questions.isEmpty {
            gameSession?.configureActualQuestion()
            configureGame()
        } else {
            print("trere is no qustions")
            endGame()
        }
    }
    
    private func configureGame() {
        guard let gameSession = gameSession, let question = gameSession.actualQuestionFacade?.question else { return }
        callToFriendView.isHidden = true
        
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
        guard let answer = button.titleLabel?.text, let facade = gameSession?.actualQuestionFacade else { return }
        if facade.isAnserRight(userAnswer: answer) {
            gameSession?.currentPersent.value += gameSession?.persentPerQuestion ?? 0
            gameSession?.score.value += 10
            gameSession?.questions?.removeFirst()
            configureActualQuestionOrEndGame()
        } else {
            print("user mistaked - game over")
            endGame()
        }
    }
    
    private func endGame() {
        dismiss(animated: true, completion: {
            self.game.addRecord(record: Record(score: self.gameSession?.score.value, name: self.gameSession?.name))
            self.delegate?.returnLastGameResult(gameSession: self.gameSession)
            self.gameSession = nil
        })
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
    
}

//MARK: - Extensions

protocol LastGameResultProtocol {
    func returnLastGameResult(gameSession: GameSession?)
}
