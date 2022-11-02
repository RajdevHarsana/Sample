//
//  SenderImageCell.swift
//  Gifts
//
//  Created by apple on 28/06/22.
//

import UIKit

class SenderImageCell: UITableViewCell {
    
    @IBOutlet weak var view_Msg: UIView!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var imageBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    func configureUI() {
        view_Msg.layer.cornerRadius = 8
        postImg.layer.cornerRadius = 5
        postImg.clipsToBounds = true
    }
}
