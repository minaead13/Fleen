//
//  UIView+Extension.swift
//  Fleen
//
//  Created by Mina Eid on 14/01/2024.
//

import UIKit

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var topLeft: Bool {
        get { return layer.maskedCorners.contains(.layerMinXMinYCorner) }
        set {
            if newValue {
                layer.maskedCorners.insert(.layerMinXMinYCorner)
            } else {
                layer.maskedCorners.remove(.layerMinXMinYCorner)
            }
        }
    }

    @IBInspectable var topRight: Bool {
        get { return layer.maskedCorners.contains(.layerMaxXMinYCorner) }
        set {
            if newValue {
                layer.maskedCorners.insert(.layerMaxXMinYCorner)
            } else {
                layer.maskedCorners.remove(.layerMaxXMinYCorner)
            }
        }
    }

    @IBInspectable var bottomLeft: Bool {
        get { return layer.maskedCorners.contains(.layerMinXMaxYCorner) }
        set {
            if newValue {
                layer.maskedCorners.insert(.layerMinXMaxYCorner)
            } else {
                layer.maskedCorners.remove(.layerMinXMaxYCorner)
            }
        }
    }

    @IBInspectable var bottomRight: Bool {
        get { return layer.maskedCorners.contains(.layerMaxXMaxYCorner) }
        set {
            if newValue {
                layer.maskedCorners.insert(.layerMaxXMaxYCorner)
            } else {
                layer.maskedCorners.remove(.layerMaxXMaxYCorner)
            }
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}



//var isPressed:Bool = true
//extension UITextField {
//    @IBInspectable
//    var placeholderColor: UIColor {
//        get {
//            guard let currentAttributedPlaceholderColor = attributedPlaceholder?.attribute(NSAttributedString.Key.foregroundColor, at: 0, effectiveRange: nil) as? UIColor else { return UIColor.clear }
//            return currentAttributedPlaceholderColor
//        }
//        set {
//            guard let currentAttributedString = attributedPlaceholder else { return }
//            let attributes = [NSAttributedString.Key.foregroundColor : newValue]
//            attributedPlaceholder = NSAttributedString(string: currentAttributedString.string, attributes: attributes)
//        }
//    }
//    @IBInspectable
//    var padding: CGFloat {
//        get {
//            return 0
//        }
//        set {
//            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.height))
//            leftView = paddingView
//            leftViewMode = .always
//            rightView = paddingView
//            rightViewMode = .always
//        }
//    }
//    /* if UITextField Password */
//    @IBInspectable
//    var isPassword: Bool {
//        set {
//            if newValue {
//                self.isSecureTextEntry = true
//
//                let paddingView = UIView(frame: CGRect(x: 20, y: 0, width: 56, height: 56))
//                let imageView = UIImageView(frame: CGRect(x: 20, y: 16, width: 28, height: 28))
//                imageView.tintColor = placeholderColor
//                imageView.image = UIImage(named: "ic_hidden")
//                imageView.contentMode = .scaleAspectFit
//
//                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
//                    imageView.isUserInteractionEnabled = true
//                    imageView.addGestureRecognizer(tapGestureRecognizer)
//
//                paddingView.addSubview(imageView)
//                rightView = paddingView
//                rightViewMode = .always
//            }
//        }
//        get {
//            return self.isPassword
//        }
//    }
//
//    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
//    {
//        let tappedImage = tapGestureRecognizer.view as! UIImageView
//        isPressed = !isPressed
//        if isPressed {
//            tappedImage.image = UIImage(named: "ic_hidden")
//            self.isSecureTextEntry = true
//        } else {
//            tappedImage.image = UIImage(named: "ic_show")
//            self.isSecureTextEntry = false
//        }
//    }
//
//    @IBInspectable
//    var requiredImage: UIImage? {
//        get {
//            return nil
//        }
//        set {
//            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
//            let imageView = UIImageView(frame: CGRect(x: 4, y: 4, width: 8, height: 8))
//            imageView.image = newValue
//            imageView.contentMode = .scaleAspectFit
//            paddingView.addSubview(imageView)
//            leftView = paddingView
//            leftViewMode = .always
//        }
//    }
//    @IBInspectable
//    var leftImage: UIImage? {
//        get {
//            return nil
//        }
//        set {
//            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 48, height: 48))
//            let imageView = UIImageView(frame: CGRect(x: 8, y: 8, width: 32, height: 32))
//            imageView.tintColor = placeholderColor
//            imageView.image = newValue
//            imageView.contentMode = .scaleAspectFit
//            paddingView.addSubview(imageView)
//            leftView = paddingView
//            leftViewMode = .always
//        }
//    }
//    @IBInspectable
//    var rightImage: UIImage? {
//        get {
//            return nil
//        }
//        set {
//            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
//            let imageView = UIImageView(frame: CGRect(x: 8, y: 8, width: 16, height: 16))
//            imageView.tintColor = placeholderColor.withAlphaComponent(0.3)
//            imageView.image = newValue
//            imageView.contentMode = .center
//            paddingView.addSubview(imageView)
//            rightView = paddingView
//            rightViewMode = .always
//        }
//    }
//
//
//        func setLeftPaddingPoints(_ amount:CGFloat){
//            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
//            self.leftView = paddingView
//            self.leftViewMode = .always
//        }
//        func setRightPaddingPoints(_ amount:CGFloat) {
//            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
//            self.rightView = paddingView
//            self.rightViewMode = .always
//        }
//
//
//
//}

extension UITextView {
    func resizeForHeight(){
        self.translatesAutoresizingMaskIntoConstraints = true
        self.sizeToFit()
        self.isScrollEnabled = false
    }
}

// MARK: -  comment for eye Password.
/*
 @IBInspectable
 var eyePassword: UIImage? {
     get {
         return nil
     }
     set {
         
         let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
         let imageView = UIImageView(frame: CGRect(x: 8, y: 8, width: 24, height: 24))
         let buttonView = UIButton(frame: CGRect(x: 8, y: 8, width: 24, height: 24))
         
         buttonView.addTarget(self, action: #selector(showPassword(sender:)), for: .touchUpInside)
         buttonView.backgroundColor = .clear
         imageView.tintColor = placeholderColor
         imageView.image = newValue
         buttonView.setImage(newValue, for: .normal)
         imageView.contentMode = .scaleAspectFit
         paddingView.addSubview(buttonView)
         //paddingView.addSubview(imageView)
         rightView = paddingView
         rightViewMode = .always
     }
 }
 
 @objc func showPassword(sender:UIButton){
     isPressed = !isPressed
     if isPressed {
         sender.setImage(UIImage(named: "ic_hiddenPass"), for: .normal)
         
         self.isSecureTextEntry = true
     } else {
         sender.setImage(UIImage(named: "ic_showPass"), for: .normal)
         self.isSecureTextEntry = false
     }
     
 }
 */



