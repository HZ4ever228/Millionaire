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
    @IBOutlet weak var qustionTextField: UITextField!
    @IBOutlet weak var firstAnswerTextField: UITextField!
    @IBOutlet weak var secondAnswerTextField: UITextField!
    @IBOutlet weak var thirdAnswerTextField: UITextField!
    @IBOutlet weak var fourthAnswerTextField: UITextField!
    @IBOutlet weak var correctAnswerControl: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
