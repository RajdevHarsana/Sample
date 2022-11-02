//
//  ReciverChatCell.swift
//  Apeiron
//
//  Created by Hardik on 20/01/22.
//  Copyright © 2022 Hardik. All rights reserved.
//

import UIKit

class ReciverChatCell: UITableViewCell {
    
    @IBOutlet weak var lbl_Date: UILabel!
    @IBOutlet weak var lbl_msg: UILabel!
    @IBOutlet weak var view_Msg: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    func configureUI() {
       
        view_Msg.layer.cornerRadius = 8
        view_Msg.layer.borderColor = UIColor.lightGray.cgColor
        view_Msg.layer.borderWidth = 0.5
    }
    
    
}
