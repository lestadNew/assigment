//
//  UITableView+Extenshion.swift
//  TestAssignment
//
//  Created by Andrey Sokolov on 15.03.2020.
//  Copyright © 2020 Dmytro Kovryhin. All rights reserved.
//

import UIKit

extension UITableView {
    func reloadWithoutAnimate(isMainQueue: Bool = true) {
        
        func reload() {
            UIView.setAnimationsEnabled(false)
            self.reloadData()
            UIView.setAnimationsEnabled(true)
        }
        
        if isMainQueue {
            DispatchQueue.main.async {
                reload()
            }
        } else {
            reload()
        }
    }
    
    func reloadIndexWithoutAnimation(indexPath: IndexPath) {
        UIView.setAnimationsEnabled(false)
        self.beginUpdates()
        self.reloadRows(at: [indexPath], with: .none)
        self.endUpdates()
        UIView.setAnimationsEnabled(true)
    }
}
