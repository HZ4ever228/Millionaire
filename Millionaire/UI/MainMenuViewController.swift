//
//  MainMenuViewController.swift
//  Millionaire
//
//  Created by Anton Hodyna on 22/03/2022.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    let game = Game.shared

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
        switch segue.identifier {
        case "segueToScoreViewController":
            guard let destanation = segue.destination as? ScoreViewController else { return }
        case "segueToGameViewController":
            guard let destanation = segue.destination as? GameViewController else { return }
            destanation.delegate = self
        case "segueToSettingsViewController":
            guard let destanation = segue.destination as? SettingsViewController else { return }
        case "segueToAddNewQuestionViewController":
            guard let destanation = segue.destination as? AddNewQuestionViewController else { return }
        default:
            break
        }
    }

}

//MARK: - Extensions

extension MainMenuViewController: LastGameResultProtocol {
    func returnLastGameResult(gameSession: GameSession?) {
        if let gameSession = gameSession {
            lastResultLabel.isHidden = false
            lastResultLabel.text = "Последний результат: \(gameSession.score.value)"
        }
    }
}


