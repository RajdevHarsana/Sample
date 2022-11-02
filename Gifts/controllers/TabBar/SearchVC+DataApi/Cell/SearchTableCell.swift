//
//  SearchTableCell.swift
//  Gifts
//
//  Created by Apple on 06/06/22.
//

import UIKit
import Designable

class SearchTableCell: UITableViewCell {

    @IBOutlet weak var lblMiles: UILabel!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var ProductImg: DesignableImageView!
    
    @IBOutlet weak var btnView: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
