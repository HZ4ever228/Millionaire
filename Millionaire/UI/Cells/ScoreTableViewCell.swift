//
//  ScoreTableViewCell.swift
//  Millionaire
//
//  Created by Anton Hodyna on 22/03/2022.
//

import UIKit

class ScoreTableViewCell: UITableViewCell {

    static let reuseIdentifier = "reuseIdentifierScoreTableViewCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
