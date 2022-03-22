//
//  ScoreViewController.swift
//  Millionaire
//
//  Created by Anton Hodyna on 22/03/2022.
//

import UIKit

class ScoreViewController: UIViewController {
    
    let game = Game.shared

    @IBOutlet weak var scoreTableView: UITableView! {
        didSet {
            scoreTableView.delegate = self
            scoreTableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension ScoreViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return game.records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ScoreTableViewCell.reuseIdentifier, for: indexPath) as? ScoreTableViewCell {
            let record = game.records[indexPath.row]
            
            if let score = record.score {
                cell.scoreLabel.text = String(score)
            }
            
            cell.nameLabel.text = record.name
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    
}
