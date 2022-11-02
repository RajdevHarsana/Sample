//
//  TallyRecordCell.swift
//  Gifts
//
//  Created by Apple on 17/02/22.
//

import UIKit

class TallyRecordCell: UITableViewCell {

    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
