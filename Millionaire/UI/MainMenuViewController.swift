//
//  MainMenuViewController.swift
//  Millionaire
//
//  Created by Anton Hodyna on 22/03/2022.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    let game = Game.shared

    @IBOutlet weak var nameTextField: UITextField! {
        didSet {
            nameTextField.delegate = self
            nameTextField.text = game.name
        }
    }
    @IBOutlet weak var lastResultLabel: UILabel! {
        didSet {
            lastResultLabel.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let text = nameTextField.text {
            game.name = text
        } else {
            game.name = "default"
        }
        switch segue.identifier {
        case "segueToScoreViewController":
            guard let destanation = segue.destination as? ScoreViewController else { return }
        case "segueToGameViewController":
            guard let destanation = segue.destination as? GameViewController else { return }
            destanation.delegate = self
        default:
            break
        }
    }

}

//MARK: - Extensions

extension MainMenuViewController: UITextFieldDelegate {
    private func textFieldShouldEndEditing(_ textField: UITextField) {
        if let text = nameTextField.text {
            game.name = text
        } else {
            game.name = "default"
        }
    }
}

extension MainMenuViewController: LastGameResultProtocol {
    func returnLastGameResult(gameSession: GameSession?) {
        if let gameSession = gameSession {
            lastResultLabel.isHidden = false
            lastResultLabel.text = "Последний результат: \(gameSession.score)"
        }
    }
}


