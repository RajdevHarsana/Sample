//
//  switches.swift
//  Gifts
//
//  Created by Apple on 20/06/22.
//

import Foundation
import UIKit

@IBDesignable

class UISwitchCustoms: UISwitch {
    @IBInspectable var OffTint: UIColor? {
        didSet {
            self.tintColor = OffTint
            self.layer.cornerRadius = 16
            self.backgroundColor = OffTint
        }
    }
}
