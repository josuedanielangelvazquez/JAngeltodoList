//
//  TaskTableViewCell.swift
//  JAngeltodoList
//
//  Created by MacBookMBA6 on 05/04/23.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var tasktable: UILabel!
    @IBOutlet weak var Timelbl: UILabel!
    @IBOutlet weak var validationlbl: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
