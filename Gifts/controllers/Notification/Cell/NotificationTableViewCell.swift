//
//  NotificationTableViewCell.swift
//  Justruck
//
//  Created by Apple on 05/05/22.
//

import UIKit
import Designable

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var userImg: DesignableImageView!
    @IBOutlet weak var btnCross: UIButton!
    @IBOutlet weak var lblNotificationTitle: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    
    @IBOutlet weak var crossWidth: NSLayoutConstraint!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var Lbldate: UILabel!
    
    @IBOutlet weak var btnMessage: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
