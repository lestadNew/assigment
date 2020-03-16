//
//  UIViewContoller+Extension.swift
//  TestAssignment
//
//  Created by Andrey Sokolov on 15.03.2020.
//  Copyright © 2020 Dmytro Kovryhin. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// Get name view controller
    var viewControllerName: String {
        return NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }
}
