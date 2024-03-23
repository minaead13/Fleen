//
//  UIViewController+Extensions.swift
//  Fleen
//
//  Created by Mina Eid on 14/01/2024.
//

import Foundation
import UIKit
import NVActivityIndicatorView

extension UIViewController {
    
    static var identifier: String {
        return String(describing: self)
    }
    
        
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
        
    }
    
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    @available(iOS 13.0, *)
    var sceneDelegate: SceneDelegate? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else { return nil }
        return delegate
    }
    
    var window: UIWindow? {
        if #available(iOS 13, *) {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate, let window = delegate.window else { return nil }
            return window
        }
        //guard let delegate = UIApplication.shared.delegate as? AppDelegate, let window = delegate.window else { return nil }
        return self.window
    }
    
    func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        return instantiateFromNib()
    }
        
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showAlertError(title: String, message: String){
     let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
     let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
     alert.addAction(okAction)
     self.present(alert, animated: true, completion: nil)
    }
    

     func displaySpinner(onView : UIView) -> UIView {
        let loaderColor = UIColor.orangePeel
        let animationFrame = CGRect(origin: CGPoint.zero, size: CGSize(width: 100, height: 100))
        let animationView = NVActivityIndicatorView(frame: animationFrame, type: NVActivityIndicatorType.ballScaleMultiple, color:loaderColor, padding: 10)
        DispatchQueue.main.async {
            animationView.center = onView.center
            onView.addSubview(animationView)
        }
        animationView.startAnimating()
        return animationView
    }
    
     func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
    
    
}

extension UIViewController {
    func setupCartBadge(count: Int?) {
        if let count = count, count > 0 {
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            button.setImage(UIImage(named: "shopping-cart"), for: .normal)
            button.addTarget(self, action: #selector(rightBarButtonTapped), for: .touchUpInside)
            
            let badgeView = UIView(frame: CGRect(x: button.frame.size.width - 20, y: 0, width: 16, height: 16))
            badgeView.backgroundColor = UIColor.gold
            badgeView.layer.cornerRadius = badgeView.frame.size.height / 2
            
            let badgeLabel = UILabel(frame: badgeView.bounds)
            badgeLabel.textAlignment = .center
            badgeLabel.textColor = UIColor.white
            badgeLabel.font = UIFont.systemFont(ofSize: 12)
            badgeLabel.text = "\(count)"
            badgeView.addSubview(badgeLabel)
            
            button.addSubview(badgeView)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(rightBarButtonTapped))
            badgeView.addGestureRecognizer(tapGesture)
            
            let barButton = UIBarButtonItem(customView: button)
            navigationItem.rightBarButtonItem = barButton
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    @objc func rightBarButtonTapped() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
