//
//  AddNewQuestionViewController.swift
//  Millionaire
//
//  Created by Anton Hodyna on 26/03/2022.
//

import UIKit

class AddNewQuestionViewController: UIViewController {
    
    let game = Game.shared

    @IBOutlet weak var addNewQuestionTableView: UITableView! {
        didSet {
            addNewQuestionTableView.delegate = self
            addNewQuestionTableView.dataSource = self
        }
    }
    
    private var newQuestionCellsAdded = 0
    private var newQuestionsArray: [Question] = []
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    
    //MARK: - Actions
    
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addNewQuestionButtonAction(_ sender: Any) {
        newQuestionCellsAdded += 1
        addNewQuestionTableView.reloadData()
    }
    
    @IBAction func addQuestionsButtonAction(_ sender: Any) {
        var cellIndexPath = 0
        for cell in addNewQuestionTableView.visibleCells {
            guard let cell = (cell as? NewQustionTableViewCell) else {return}
            if cell.isQuestionReadyToAppend() {
                newQuestionsArray.append(cell.addQustion())
                cell.clearCell()
                newQuestionCellsAdded -= 1
                addNewQuestionTableView.deleteRows(at: [[0, cellIndexPath]], with: .middle)
            } else {
                print("somethink wrong with question \(cell.qustionTextField.text)")
                presentAlert(withTitle: "Questions add error", message: "Some of the fields is empty", callback: {
                })
            }
            cellIndexPath += 1
        }
        
        if !newQuestionsArray.isEmpty {
            print(newQuestionsArray)
            game.addUserQuestions(questions: newQuestionsArray)
            newQuestionsArray.removeAll()
        }
        
    }
    
}

//MARK: - Extensions

extension AddNewQuestionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newQuestionCellsAdded
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: NewQustionTableViewCell.reuseIdentifier, for: indexPath) as? NewQustionTableViewCell {
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
}
