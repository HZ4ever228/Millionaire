//
//  SettingsViewController.swift
//  Millionaire
//
//  Created by Anton Hodyna on 24/03/2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let game = Game.shared

    @IBOutlet weak var qustionsSortControl: UISegmentedControl! {
        didSet {
            switch game.questionsStrategy {
            case .sequensial:
                qustionsSortControl.selectedSegmentIndex = 0
            case .random:
                qustionsSortControl.selectedSegmentIndex = 1
            }
        }
    }
    @IBOutlet weak var nameTextField: UITextField! {
        didSet {
            nameTextField.delegate = self
            nameTextField.text = game.name
        }
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - Actions
    
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func questionSortControlActions(_ sender: Any) {
        switch qustionsSortControl.selectedSegmentIndex {
            case 0:
            game.changeQustionSortStrategy(strategy: .sequensial)
            case 1:
            game.changeQustionSortStrategy(strategy: .random)
            default:
            game.changeQustionSortStrategy(strategy: .sequensial)
        }
    }
}

//MARK: - Extensions

extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = nameTextField.text {
            game.setName(newName: text)
        }
    }
}
