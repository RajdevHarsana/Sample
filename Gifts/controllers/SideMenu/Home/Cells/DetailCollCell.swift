//
//  DetailCollCell.swift
//  Gifts
//
//  Created by Apple on 03/06/22.
//

import UIKit
import Designable

class DetailCollCell: UICollectionViewCell {
    @IBOutlet weak var imageCountView: DesignableView!
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var LblScrollImg: UILabel!
    @IBOutlet weak var LblTotalImages: UILabel!
    
    @IBOutlet weak var btnZoomImage: UIButton!
    func selectedIndexPath(_ indexPath: IndexPath) {

           //Do your business here.
       }
}
