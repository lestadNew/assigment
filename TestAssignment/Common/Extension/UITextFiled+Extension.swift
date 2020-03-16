//
//  UITextFiled+Extension.swift
//  TestAssignment
//
//  Created by Andrey Sokolov on 15.03.2020.
//  Copyright © 2020 Dmytro Kovryhin. All rights reserved.
//

import UIKit

/// MARK: - ToolBar
extension UITextField {
    
    /// Display toolbar with done button above the keyboard if `true`
    @IBInspectable public var showDoneButton: Bool {
        set {
            self.addToolbarAccessoryView(items: [
                UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(resignFirstResponder))
                ])
        }
        get {
            return self.containsToolbarAccessoryView
        }
    }
    
    /// Return `true` if `inputAccessoryView` is class of `UIToolbar
    var containsToolbarAccessoryView: Bool {
        return self.inputAccessoryView is UIToolbar
    }
    
    /// Add `toolbar` to `inputAccessoryView` with bar style, tint color and items.
    ///
    /// - Parameters:
    ///   - barStyle: The toolbar style that specifies its appearance
    ///   - tintColor: The tint color to apply to the bar button items
    ///   - items: The items displayed on the toolbar
    func addToolbarAccessoryView(barStyle: UIBarStyle, tintColor: UIColor, items: [UIBarButtonItem]) {
        if self.containsToolbarAccessoryView {
            debugPrint("UITextField: Can't addToolbarAccessoryView(barStyle:tintColor:items:) because `inputAccessoryView` already exist")
            return
        }
        
        self.inputAccessoryView = {
            let toolbar = UIToolbar()
            toolbar.isTranslucent = true
            toolbar.barStyle = barStyle
            toolbar.tintColor = tintColor
            toolbar.items = items
            toolbar.sizeToFit()
            return toolbar
        }()
    }
    
    /// Add `toolbar` to `inputAccessoryView` with items.
    ///
    /// - Parameter items: The items displayed on the toolbar
    func addToolbarAccessoryView(items: [UIBarButtonItem]) {
        let isDark = self.keyboardAppearance == .dark
        self.addToolbarAccessoryView(barStyle: isDark ? .black : .default, tintColor: isDark ? .white : .black, items: items)
    }
    
    /// Remove inputAccessoryView if exist and it is class of UIToolbar
    func removeToolbarAccessoryView() {
        guard self.containsToolbarAccessoryView else {
            debugPrint("UITextField: Can't removeToolbarAccessoryView() because `inputAccessoryView` isn't UIToolbar")
            return
        }
        self.inputAccessoryView = nil
    }
    
    /// Setup toolbar with next
    func setupNextToolbar() {
        self.addToolbarAccessoryView(items: [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Next", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.nextTextField))
            ])
    }
    
    @objc func nextTextField() {
        _ = delegate?.textFieldShouldReturn?(self)
    }
    
}
