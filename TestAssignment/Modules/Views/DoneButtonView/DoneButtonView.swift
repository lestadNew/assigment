//
//  DoneButtonView.swift
//  TestAssignment
//
//  Created by Andrey Sokolov on 15.03.2020.
//  Copyright © 2020 Dmytro Kovryhin. All rights reserved.
//

import UIKit

protocol DoneButtonViewDelegate: class {
    func doneButtonViewApply(view: DoneButtonView)
}
class DoneButtonView: UIView, LoadFromXibProtocol {
    @IBOutlet weak var doneButton: UIButton!
    
    weak var delegate: DoneButtonViewDelegate?
    
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
        doneButton.setTitle(Constant.Localized.DoneButton.titleButton, for: .normal)
    }
    
    //MARK: - Actions
    @IBAction func actionDone(_ sender: UIButton) {
        delegate?.doneButtonViewApply(view: self)
    }
}
