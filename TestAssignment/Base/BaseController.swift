//
//  BaseController.swift
//  TestAssignment
//
//  Created by Andrey Sokolov on 15.03.2020.
//  Copyright © 2020 Dmytro Kovryhin. All rights reserved.
//

import UIKit

class BaseController: UIViewController {

    /// Bottom view constraint for keyboard
    @IBOutlet weak var bottomViewConstraint: NSLayoutConstraint!
    
    var correction: CGFloat = 0.0
    var keyboardHeight: CGFloat = 0.0
    var isShowKeyboard = false
    
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hideKeyboard()
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        debugPrint(" deinit ----->>>> \(viewControllerName)")
        NotificationCenter.default.removeObserver(self)
    }
}

//MARK - Keyboard
extension BaseController{
    /// Keyboard will hide
    ///
    /// - parameter notification: object notification
    @objc func keyboardWillHide(_ notification : Notification) {
        if bottomViewConstraint != nil {
            bottomViewConstraint!.constant = 0
            keyboardHeight = 0
            UIView.animate(withDuration: 0.4, animations: { () -> Void in
                self.view.layoutIfNeeded()
            })
        }
    }

    /// Keyboard will show
    ///
    /// - parameter notification: object notification
    @objc func keyboardWillShow(_ notification: Notification) {
        isShowKeyboard = true

        if bottomViewConstraint != nil {
            let info = notification.userInfo!
            let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue

            let bottomPadding: CGFloat = {

                let tabBarHieght: CGFloat = tabBarController?.tabBar.frame.size.height ?? 0

                if tabBarHieght == 0 || (tabBarController?.tabBar.isHidden ?? false) {
                    if #available(iOS 11.0, *) {
                        return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
                    } else {
                        return 0
                    }
                } else {
                    return tabBarHieght
                }

            } ()


            keyboardHeight = keyboardFrame.size.height

            bottomViewConstraint.constant = keyboardHeight - bottomPadding + correction

            UIView.animate(withDuration: 0.4, animations: { () -> Void in
                self.view.layoutIfNeeded()
            })
        }
    }
    
    /// Hide keyboard
    @objc func hideKeyboard() {

        isShowKeyboard = false
        view.endEditing(true)
    }
}
