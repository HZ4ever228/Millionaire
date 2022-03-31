//
//  NewQustionTableViewCell.swift
//  Millionaire
//
//  Created by Anton Hodyna on 26/03/2022.
//

import UIKit

class NewQustionTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "reuseIdentifierNewQustionTableViewCell"
    
    @IBOutlet weak var questionCountLabel: UILabel!
    @IBOutlet weak var qustionTextField: UITextField! {
        didSet {
            qustionTextField.delegate = self
        }
    }
    @IBOutlet weak var firstAnswerTextField: UITextField! {
        didSet {
            firstAnswerTextField.delegate = self
        }
    }
    @IBOutlet weak var secondAnswerTextField: UITextField! {
        didSet {
            secondAnswerTextField.delegate = self
        }
    }
    @IBOutlet weak var thirdAnswerTextField: UITextField! {
        didSet {
            thirdAnswerTextField.delegate = self
        }
    }
    @IBOutlet weak var fourthAnswerTextField: UITextField! {
        didSet {
            fourthAnswerTextField.delegate = self
        }
    }
    @IBOutlet weak var correctAnswerControl: UISegmentedControl!
    
    private let builder = QuestionBuilder()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func clearCell() {
        qustionTextField.text = nil
        firstAnswerTextField.text = nil
        secondAnswerTextField.text = nil
        thirdAnswerTextField.text = nil
        fourthAnswerTextField.text = nil
        correctAnswerControl.selectedSegmentIndex = 0
    }
    
    //MARK: - Actions
    
    
    func isQuestionReadyToAppend() -> Bool {
        [qustionTextField, firstAnswerTextField, secondAnswerTextField, thirdAnswerTextField, fourthAnswerTextField].forEach({
            $0?.endEditing(true)
        })
        return builder.isQuestionReadyForBuild()
    }
    
    func addQustion() -> Question {
         builder.build(correctAnswer: correctAnswerControl.selectedSegmentIndex)
    }
    
}

//MARK: - Extensions

extension NewQustionTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            switch textField {
            case qustionTextField:
                builder.addQuestion(text)
                print(builder.question)
            case firstAnswerTextField:
                builder.addFirstAnswer(text)
                print(builder.firstAnswer)
            case secondAnswerTextField:
                builder.addSecondAnswer(text)
                print(builder.secondAnswer)
            case thirdAnswerTextField:
                builder.addThirdAnswer(text)
                print(builder.thirdAnswer)
            case fourthAnswerTextField:
                builder.addFourthAnswer(text)
                print(builder.fourthAnswer)
            default:
                print("error textFieldSellection")
            }
        }
    }
}
