//
//  AddNewQuestionViewController.swift
//  Millionaire
//
//  Created by Anton Hodyna on 26/03/2022.
//

import UIKit

class AddNewQuestionViewController: UIViewController {

    @IBOutlet weak var addNewQuestionTableView: UITableView! {
        didSet {
            addNewQuestionTableView.delegate = self
            addNewQuestionTableView.dataSource = self
        }
    }
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - Actions
    
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func addNewQuestionButtonAction(_ sender: Any) {
        print("newQuestion is added")
    }
    @IBAction func addQuestionsButtonAction(_ sender: Any) {
        print("All questions was added in memory")
    }
    
}

//MARK: - Extensions

extension AddNewQuestionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
