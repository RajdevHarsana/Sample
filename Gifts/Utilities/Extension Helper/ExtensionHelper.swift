//
//  ExtensionHelper.swift
//  Gifts
//
//  Created by Apple on 22/07/20.
//  Copyright © 2020 Pankaj. All rights reserved.
//

import Foundation
import UIKit


extension UILabel
{
  func attribultedString()
  {
    let string = "Testing Attributed Strings"
    let attributedString = NSMutableAttributedString(string: string)
  }
}
extension UITextField {

    enum PaddingSide {
        case left(CGFloat)
        case right(CGFloat)
        case both(CGFloat)
    }

    func addPadding(_ padding: PaddingSide) {
        self.leftViewMode = .always
        self.layer.masksToBounds = true
        switch padding {
        case .left(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.leftView = paddingView
            self.rightViewMode = .always
        case .right(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.rightView = paddingView
            self.rightViewMode = .always
        case .both(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            // left
            self.leftView = paddingView
            self.leftViewMode = .always
            // right
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }
}
extension UserDefaults {
    func imageArray(forKey key: String) -> [UIImage]? {
        guard let array = self.array(forKey: key) as? [Data] else {
            return nil
        }
        return array.compactMap() { UIImage(data: $0) }
    }
    func set(_ imageArray: [UIImage], forKey key: String) {
        self.set(imageArray.compactMap({ $0.pngData() }), forKey: key)
    }
}
extension Date {
 static func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        return dateFormatter.string(from: Date())
    }
}
extension UIButton{
    func setButtonCornerRadiusOnly(getValue:CGFloat){
        self.layer.cornerRadius = getValue
        self.clipsToBounds = true
    }
    func setButtonBorderColorAndHeight(getHeight:CGFloat,getColor:UIColor){
        self.layer.borderColor = getColor.cgColor
        self.layer.borderWidth = getHeight
    }
    func setBtnWithShadow(){
        self.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 1.5
        self.layer.cornerRadius = self.frame.size.height/2
        self.layer.masksToBounds =  false
    }
}
extension UIView {
    
    func setShadowForNavView(){
      self.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)
      self.layer.shadowOpacity = 0.3
      self.layer.shadowRadius = 1
      self.layer.cornerRadius = 0
      self.layer.masksToBounds =  false
    }
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    func setViewCornerRadiusCircular(){
        self.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 1.5
        self.layer.cornerRadius = self.frame.size.height/2
        self.layer.masksToBounds =  false
    }
    func setViewCornerRadiusCircularCustomValue(value:CGFloat){
        self.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 1.5
        self.layer.cornerRadius = value
        self.layer.masksToBounds =  false
    }
}
extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}

