//
//  CloseButton.swift
//  TestAssignment
//
//  Created by Andrey Sokolov on 15.03.2020.
//  Copyright © 2020 Dmytro Kovryhin. All rights reserved.
//

import UIKit

protocol CloseButtonDelegate: class {
    func closeButton(view: CloseButton)
}

class CloseButton: UIView, LoadFromXibProtocol {
    
    weak var delegate: CloseButtonDelegate?
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    //MARK: - Setup
    private func setup() {
        self.addSubviewLoadedFromXib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.addGestureRecognizer(tap)
    }
    
    //MARK: - Actions
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        delegate?.closeButton(view: self)
    }
}
