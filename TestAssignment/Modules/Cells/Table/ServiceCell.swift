//
//  ServiceCell.swift
//  TestAssignment
//
//  Created by Andrey Sokolov on 15.03.2020.
//  Copyright © 2020 Dmytro Kovryhin. All rights reserved.
//

import UIKit

class ServiceCell: UITableViewCell {

    //MARK: - IBOutlet
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var checkMarkImageView: UIImageView!
    
    var service: ServiceModel?
    
    //MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setModel(service: ServiceModel) {
        self.service = service
        serviceLabel.text = service.conditions.title
        descriptionView.isHidden = !service.isShowsComment
        checkMarkImageView.isHidden = !service.isSelected
        
        if let commentary = service.commentaryConditions {
            descriptionTextField.text = commentary
        }
        
        descriptionTextField.delegate = self
    }
    
    //MARK: - Actions
    @IBAction func actionEditingTextFiled(_ sender: UITextField) {
        service?.commentaryConditions = sender.text
        descriptionTextField.text = sender.text
    }
}

//MARK: - UITextFieldDelegate
extension ServiceCell: UITextFieldDelegate {
}
