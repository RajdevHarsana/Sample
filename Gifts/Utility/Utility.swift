//
//  Utility.swift
//  NearBuyLife
//
//  Created by GANESH on 25/06/20.
//  Copyright © 2020 ganesh. All rights reserved.


import Foundation
import UIKit

 private var __maxLengths = [UITextField: Int]()


class Utility
{

    //static func showAlertMessage(vc: UIViewController?, titleStr:String, messageStr:String) -> Void
//    {
//        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert);
//        let action = UIAlertAction.init(title: "ok", style: .default, handler: nil)
//        alert.addAction(action)
//        if (vc == nil)
//        {
//            if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
//                window.rootViewController?.present(alert, animated: true, completion: nil)
//            }
//        }
//        else
//        {
//            vc?.present(alert, animated: true, completion: nil)
//        }
//    }
}





@IBDesignable

  class UISwitchCustom: UISwitch {
      @IBInspectable var OffTint: UIColor? {
          didSet {
              self.tintColor = OffTint
             // self.layer.cornerRadius = 20
              self.backgroundColor = OffTint
          }
      }
  }





// For the RoundedButton with border color and cornerradius also for UIButton.

@IBDesignable
class RoundButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var borderColor: UIColor = UIColor.clear{
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
}

//  For the Roundedview with border color and cornerradius also for UIView.
@IBDesignable
class RoundedView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var borderColor: UIColor = UIColor.clear{
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable var rightSideCorner: CGFloat = 0{
        didSet{
            self.layer.maskedCorners = .layerMinXMaxYCorner
        }
    }




    func removeLayer(layerName: String) {
        for item in self.layer.sublayers ?? [] where item.name == layerName {
            item.removeFromSuperlayer()
        }
    }


    enum ViewSide {
        case left, right, top, bottom
    }

    func addBorder(toSide side: ViewSide, withSpace space: CGFloat, withColor color:UIColor) {

        DispatchQueue.main.async {
            let border = CALayer()
            border.backgroundColor = color.cgColor

            switch side {
            case .top:
                border.frame = CGRect(x: space, y: 0, width: self.frame.size.width - (space * 2), height: 1)
            case .bottom:
                border.frame = CGRect(x: space, y: self.frame.size.height - 1, width: self.frame.size.width - (space * 2), height: 1)
            case .left:
                border.frame = CGRect(x: 0, y: space, width: 1, height: self.frame.size.height - (space * 2))
            case .right:
                border.frame = CGRect(x: self.frame.size.width - 1, y: space, width: 1, height: self.frame.size.height - (space * 2))
            }

            self.layer.addSublayer(border)
        }
    }




//
//    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
//        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//        let mask = CAShapeLayer()
//        mask.path = path.cgPath
//        layer.mask = mask
//    }
//


}

//Round image
@IBDesignable
class RoundImg: UIImageView {

    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var borderColor: UIColor = UIColor.clear{
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
}




@IBDesignable
class GradientView: UIView {

    override class var layerClass: AnyClass { return CAGradientLayer.self }

    private var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }

    @IBInspectable var color1: UIColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.0) { didSet { updateColors() } }
    @IBInspectable var color2: UIColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.0) { didSet { updateColors() } }
   // @IBInspectable var color3: UIColor = UIColor(red: 80, green: 62, blue: 167, alpha: 1) { didSet { updateColors() } }


    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configureGradient()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureGradient()
    }

    private func configureGradient() {
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        updateColors()
    }

    private func updateColors() {
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
    }

}




@IBDesignable
class GradientView1: UIView {

    override class var layerClass: AnyClass { return CAGradientLayer.self }

    private var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }

    @IBInspectable var color1: UIColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.0) { didSet { updateColors() } }
    @IBInspectable var color2: UIColor = UIColor(red: 255 , green: 255, blue: 255, alpha: 0.0
        ) { didSet { updateColors() } }


    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configureGradient()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureGradient()
    }

    private func configureGradient() {
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        updateColors()
    }

    private func updateColors() {
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
    }

}







@IBDesignable
class GradientButton: UIButton {

    override class var layerClass: AnyClass { return CAGradientLayer.self }

    private var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }

    @IBInspectable var color1: UIColor = UIColor(red: 42, green: 87, blue: 253, alpha: 1) { didSet { updateColors() } }
    @IBInspectable var color2: UIColor = UIColor(red: 61, green: 84, blue: 172, alpha: 1) { didSet { updateColors() } }


    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configureGradient()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureGradient()
    }

    private func configureGradient() {
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        updateColors()
    }

    private func updateColors() {
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
    }

}


@IBDesignable
class GradientButton1: UIButton {


    override class var layerClass: AnyClass { return CAGradientLayer.self }

    private var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }

    @IBInspectable var color1: UIColor = UIColor(red: 69, green: 221, blue: 33, alpha: 1) { didSet { updateColors() } }
    @IBInspectable var color2: UIColor = UIColor(red: 61, green: 191, blue: 25, alpha: 1) { didSet { updateColors() } }


    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configureGradient()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureGradient()
    }

    private func configureGradient() {
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        updateColors()
    }

    private func updateColors() {
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
    }

}



extension UITextField {

    func setLeftPaddingPoints(_ width:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }

    func setRightPaddingPoints(_ width:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }

    func setLeftPaddingImage( _ leftImage:UIImage, frame : CGRect, contentMode : ContentMode? = .center) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.height, height: self.frame.size.height))

        let paddingImage = UIImageView(frame: frame)
        paddingImage.clipsToBounds = true
        paddingImage.contentMode = contentMode!
        paddingImage.image = leftImage

        paddingView.addSubview(paddingImage)

        self.leftView = paddingView
        self.leftViewMode = .always
    }

    func setRightPaddingImage( _ rightImage:UIImage, frame : CGRect, contentMode : ContentMode? = .center) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.height, height: self.frame.size.height))

        let paddingImage = UIImageView(frame: frame)
        paddingImage.clipsToBounds = true
        paddingImage.contentMode = contentMode!
        paddingImage.image = rightImage

        paddingView.addSubview(paddingImage)

        self.rightView = paddingView
        self.rightViewMode = .always
    }

    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
//
//    @IBInspectable var maxLength: Int {
//        get {
//            guard let l = __maxLengths[self] else {
//                return 150 // (global default-limit. or just, Int.max)
//            }
//            return l
//        }
//        set {
//            __maxLengths[self] = newValue
//            addTarget(self, action: #selector(fix), for: .editingChanged)
//        }
//    }

//    @objc func fix(textField: UITextField) {
//        let t = textField.text
//        textField.text = t?.safelyLimitedTo(length: maxLength)
//    }
}

extension UIViewController {

    // Show AlertMessage
    func showAlert(_ title: String, _ message:String,_ buttonTitle:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default) { (action: UIAlertAction) in

        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }


}




extension String
{
    func safelyLimitedTo(length n: Int)->String {
        if (self.count <= n) {
            return self
        }
        return String( Array(self).prefix(upTo: n) )
    }

    var numberValue: NSNumber? {
        if let value = Int(self) {
            return NSNumber(value: value)
        }
        return nil
    }
}


extension UIView {
    func setOneSideCorner(outlet:UIView){
        //Corner radius for view.
        outlet.clipsToBounds = true
        outlet.layer.cornerRadius = 25
        outlet.layer.maskedCorners = [.layerMinXMaxYCorner]
    }

    func dropShadow(view: UIView, opacity: Float){
        view.layer.shadowColor = UIColor.brown.cgColor
        view.layer.shadowOpacity = opacity
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 5
    }


    enum ViewSide1 {
           case left, right, top, bottom
       }

       func addBorder(toSide side: ViewSide1, withSpace space: CGFloat, withColor color:UIColor) {

           DispatchQueue.main.async {
               let border = CALayer()
               border.backgroundColor = color.cgColor

               switch side {
               case .top:
                   border.frame = CGRect(x: space, y: 0, width: self.frame.size.width - (space * 2), height: 1)
               case .bottom:
                   border.frame = CGRect(x: space, y: self.frame.size.height - 1, width: self.frame.size.width - (space * 2), height: 1)
               case .left:
                   border.frame = CGRect(x: 0, y: space, width: 1, height: self.frame.size.height - (space * 2))
               case .right:
                   border.frame = CGRect(x: self.frame.size.width - 1, y: space, width: 1, height: self.frame.size.height - (space * 2))
               }

               self.layer.addSublayer(border)
           }
       }

}

extension UIViewController{
//    func dropShadow(view: UIView, opacity: Float){
//        view.layer.shadowColor = UIColor.lightGray.cgColor
//        view.layer.shadowOpacity = opacity
//        view.layer.shadowOffset = CGSize(width: 3, height: 3)
//        view.layer.shadowRadius = 5
//    }


    func dropShadow(view: UIView){
        view.layer.shadowColor = UIColor(red: 47/255.0, green: 48/255.0, blue: 87/255.0, alpha: 0.12).cgColor
        view.layer.shadowOpacity = 2.0
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowRadius = 40
        view.layer.masksToBounds = false
    }

    func viewShadow(view: UIView) {
        view.layer.shadowColor = UIColor(red: 47/255.0, green: 48/255.0, blue: 87/255.0, alpha: 0.12).cgColor
        view.layer.shadowOpacity = 1.0
        view.layer.shadowOffset = CGSize(width: 6, height: 6)
        view.layer.shadowRadius = 10



    }


    func viewOrdersShadow(view: UIView,color: UIColor, opacity: Float = 5.0) {
           view.layer.shadowColor = color.cgColor
           view.layer.shadowOpacity = opacity
           view.layer.shadowOffset = CGSize(width: 0, height: 0)
           view.layer.shadowRadius = 2


       }




    func hideNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }

    func unHideNavigationBar() {
        self.navigationController?.isNavigationBarHidden = false
    }

    //MARK:- View Controller extension


    func addGradientNavigarion() {
        if let navigationBar = self.navigationController?.navigationBar {
            let gradient = CAGradientLayer()
            var bounds = navigationBar.bounds
            bounds.size.height += UIApplication.shared.statusBarFrame.size.height
            gradient.frame = bounds

            let color1 = Color.darkBlue.cgColor
          //  let color2 = Color.blue.cgColor

           // gradient.colors = [color1, color2]
            gradient.colors = [color1]
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 1, y: 0)

            if let image = getImageFrom(gradientLayer: gradient) {
                navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
            }
        }
    }

    func getImageFrom(gradientLayer:CAGradientLayer) -> UIImage? {
        var gradientImage:UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }


    func setNavigationBarTransparent() {
        // Sets background to a blank/empty image
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        // Sets shadow (line below the bar) to a blank image
        UINavigationBar.appearance().shadowImage = UIImage()
        // Sets the translucent background color
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().barTintColor = .clear
        // Set translucent. (Default value is already true, so this can be removed if desired.)
        UINavigationBar.appearance().isTranslucent = true
    }

    func removeNavigationBarTransparency() {

        // Sets background to a blank/empty image
        UINavigationBar.appearance().setBackgroundImage(nil, for: .default)
        // Sets shadow (line below the bar) to a blank image
        UINavigationBar.appearance().shadowImage = UIImage()
        // Sets the translucent background color
        UINavigationBar.appearance().backgroundColor = .white
        UINavigationBar.appearance().barTintColor = .white
        // Set translucent. (Default value is already true, so this can be removed if desired.)
        UINavigationBar.appearance().isTranslucent = false
    }

    func addBarBackButton(image : UIImage, text : String) {
        let img = image
        let leftBtn = UIBarButtonItem(image: img, style: .plain, target: self, action: #selector(self.backMothod))
        let titleLbl = UIBarButtonItem(title: text, style: .plain, target: self, action: #selector(self.backMothod))

        let attrs1 = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15.0)
        ]

        titleLbl.setTitleTextAttributes(attrs1, for: .normal)
        navigationItem.leftBarButtonItems = [leftBtn, titleLbl]

    }

    @objc func backMothod() {
        navigationController?.popViewController(animated: true)
    }





//    func addMenuButton(image : UIImage, text : String) {
//        let img = image
//        let leftBtn = UIBarButtonItem(image: img, style: .plain, target: self, action: #selector(menuBtnAction))
//        let title = UIBarButtonItem(title: text, style: .plain, target: self, action: #selector(menuBtnAction))
//
//        let attrs1 = [
//            NSAttributedString.Key.foregroundColor: UIColor.white,
//            NSAttributedString.Key.font: UIFont(name: Fonts.avenirBlack, size: 17)!
//        ]
//
//        title.setTitleTextAttributes(attrs1, for: .normal)
//        self.navigationItem.leftBarButtonItems = [leftBtn, title]
//    }


    func hideBackBtn() {
        self.navigationItem.setHidesBackButton(true, animated:true);
    }

//    func hideNavigationBar() {
//        self.navigationController?.isNavigationBarHidden = true
//    }
//
//    func unHideNavigationBar() {
//        self.navigationController?.isNavigationBarHidden = false
//    }

//    func addRightBarButtonWithtext(title:String, color : UIColor) {
//        let btn = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(self.rightBarButtonAction))
//
//        let attrs1 = [
//            NSAttributedString.Key.foregroundColor: color,
//            NSAttributedString.Key.font: UIFont(name: Fonts.avenirBlack, size: 12)!
//        ]
//        btn.setTitleTextAttributes(attrs1, for: .normal)
//        self.navigationItem.rightBarButtonItem = btn
//    }
//
//    @objc func rightBarButtonAction() {
//
//    }

//    func addRightBarButtonWithImage(image:UIImage, tintColor : UIColor?) {
//
//        let btn = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(self.rightBarButtonWithImageAction))
//        if tintColor != nil {
//            btn.tintColor = tintColor
//        }
//        self.navigationItem.rightBarButtonItem = btn
//    }
//
//    @objc func rightBarButtonWithImageAction() {
//
//    }
//
//    func addLeftBarButtonWithtext(title:String, color : UIColor) {
//        let btn = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(self.LeftBarButtonAction))
//        let attrs1 = [
//            NSAttributedString.Key.foregroundColor: color,
//            NSAttributedString.Key.font: UIFont(name: Fonts.avenirBlack, size: 12)!
//        ]
//        btn.setTitleTextAttributes(attrs1, for: .normal)
//
//        self.navigationItem.leftBarButtonItem = btn
//    }

    @objc func LeftBarButtonAction() {

    }

    func addLeftBarButtonWithImage(image:UIImage, tintColor : UIColor?) {

        let btn = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(self.LeftBarButtonWithImageAction))
        if tintColor != nil {
            btn.tintColor = tintColor
        }
        self.navigationItem.leftBarButtonItem = btn
    }

    @objc func LeftBarButtonWithImageAction() {

    }

    func pushToViewController(Identifier: String) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: Identifier)
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
}

extension UIApplication
{
    var statusBarView: UIView?{
        return value(forKey: "statusBar") as? UIView
    }


}


extension UITextView: UITextViewDelegate {
    
    /// Resize the placeholder when the UITextView bounds change
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }
    
    /// The UITextView placeholder text
    public var placeholder: String? {
        get {
            var placeholderText: String?
            
            if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                placeholderText = placeholderLabel.text
            }
            
            return placeholderText
        }
        set {
            if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
                placeholderLabel.text = newValue
                placeholderLabel.sizeToFit()
            } else {
                self.addPlaceholder(newValue!)
            }
        }
    }
    
    /// When the UITextView did change, show or hide the label based on if the UITextView is empty or not
    ///
    /// - Parameter textView: The UITextView that got updated
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = !self.text.isEmpty
        }
    }
    
    /// Resize the placeholder UILabel to make sure it's in the same position as the UITextView text
    private func resizePlaceholder() {
        if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
            let labelX = self.textContainer.lineFragmentPadding
            let labelY = self.textContainerInset.top - 2
            let labelWidth = self.frame.width - (labelX * 2)
            let labelHeight = placeholderLabel.frame.height

            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
    }
    
    /// Adds a placeholder UILabel to this UITextView
    private func addPlaceholder(_ placeholderText: String) {
        let placeholderLabel = UILabel()
        
        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()
        
        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.tag = 100
        
        placeholderLabel.isHidden = !self.text.isEmpty
        
        self.addSubview(placeholderLabel)
        self.resizePlaceholder()
        self.delegate = self
    }
    
}
