//
//  ExpenseCell.swift
//  ExpenseTrackerApp
//
//  Created by Chandani on 25/12/21.
//

import UIKit

class ExpenseCell: UITableViewCell {

    @IBOutlet weak var expenceTitle : UILabel!
    @IBOutlet weak var expenceAmount : UILabel!
    @IBOutlet weak var expenceNotes : UILabel!
    @IBOutlet weak var expenceDate : UILabel!
    @IBOutlet weak var expenceCategory : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
