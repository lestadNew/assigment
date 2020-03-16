//
//  File.swift
//  TestAssignment
//
//  Created by Andrey Sokolov on 15.03.2020.
//  Copyright © 2020 Dmytro Kovryhin. All rights reserved.
//

import UIKit

protocol LoadFromXibProtocol: class {
    
    /// The name will used for unarchives the contents of a nib file.
    static var nibName: String { get }
    
    /// The bundle will used for unarchives the contents of a nib file.
    static var nibBundle: Bundle? { get }
    
}

// MARK: - Default
extension LoadFromXibProtocol {
    
    static var nibName: String {
        return String(describing: self)
    }
    
    static var nibBundle: Bundle? {
        return nil
    }
    
    /// Unarchives and instantiates the in-memory contents of the receiver’s nib file based on `nibName` and `nibBundle`.
    /// - parameter owner: The object to use as the owner of the nib file. If the nib file has an owner, you must specify a valid object for this parameter.
    /// - returns: Unarchives and instantiates xib view.
    static func loadFromXib(owner: Any? = nil) -> UIView? {
        let nib = UINib(nibName: self.nibName, bundle: self.nibBundle)
        return nib.instantiate(withOwner: owner).first as? UIView
    }
    
    /// Unarchives and instantiates the in-memory contents of the receiver’s nib file based on `nibName` and `nibBundle`. _The same is loadFromXib(owner:) but typed to Self_
    /// - parameter owner: The object to use as the owner of the nib file. If the nib file has an owner, you must specify a valid object for this parameter.
    /// - returns: Unarchives and instantiates xib view.
    static func nibView(owner: Any? = nil) -> Self {
        if let view = self.loadFromXib(owner: owner) as? Self {
            return view
        } else {
            fatalError("LoadFromXibProtocol can't load view from Xib named \(nibName). Xib view must have class \(nibName) instead \(type(of: nibView))")
        }
    }
    
}

// MARK: - UIView + Xib
extension LoadFromXibProtocol where Self: UIView {
    
    /// Return subview which added from xib
    var nibSubview: UIView? {
        return self.subviews.first { $0.isNibSubview }
    }
    
    /// Unarchives and instantiates the in-memory contents of the receiver’s nib file based on `nibName` and `nibBundle`, creating a distinct object tree and set of top level objects
    func addSubviewLoadedFromXib(configureHandler: ((UIView) ->())? = nil) {
        guard self.nibSubview == nil else {
            debugPrint("LoadFromXibProtocol: Instantiate view for \(Self.nibName) already added. You must remove `nibSubview` before add new one")
            return
        }
        
        guard let nibView = Self.loadFromXib(owner: self) else {
            assertionFailure("LoadFromXibProtocol: Doesn't have instantiate view for \(Self.nibName)")
            return
        }
        
        nibView.isNibSubview = true
        nibView.frame = CGRect(origin: .zero, size: self.bounds.size)
        nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        configureHandler?(nibView)
        self.addSubview(nibView)
        
    }
    
}

// MARK: - UIView + Nib Subview
extension UIView {
    
    fileprivate(set) var isNibSubview: Bool {
        get {
            return self.layer.value(forKey: "isNibSubview") as? Bool ?? false
        }
        set {
            self.layer.setValue(newValue, forKey: "isNibSubview")
        }
    }
    
}
