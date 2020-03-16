//
//  MainServiceController.swift
//  TestAssignment
//
//  Created by Andrey Sokolov on 15.03.2020.
//  Copyright © 2020 Dmytro Kovryhin. All rights reserved.
//

import UIKit

class MainServiceController: BaseController {
    
    //MARK: - IBOutlet
    @IBOutlet private weak var serviceButton: UIButton!
    @IBOutlet private weak var
    hiddenSwitch: UISwitch!
    @IBOutlet private weak var serviceLabel: UILabel!
    
    private var serviceHidden: Set<AdditionalConditions> = [.baggage]
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
        serviceButton.setTitle(Constant.Localized.MainContoller.buttonTitle, for: .normal)
    }
    
    //MARK: - Private methods
    private func updateUI() {
        serviceLabel.text = ArchiveService.standart.servicesModels.compactMap({
            if $0.isSelected == true {
                return $0.conditions.title + " (\(($0.commentaryConditions ?? "")))"
            } else {
                return nil
            }
        }).joined(separator: "\n")
    }
    
    //MARK: - Actions
    @IBAction func actionUpdateSwitch(_ sender: UISwitch) {
        //TODO: тут не очень понял, надо было сразу менять/добавлять определенные значения или нет, можно было defaultsService передать значения например:
        //ServiceModel.defaultsService(hiddensService: (isHidden: hiddenSwitch.isOn, servicesHidden: serviceHidden))
        ArchiveService.standart.servicesModels = []
        updateUI()
    }
    
    @IBAction func actionOpernService(_ sender: UIButton) {
        ServiceRouter(presenter: navigationController).pushServiceContoller(delegate: self, hiddenServiceIndex: (isHidden: hiddenSwitch.isOn, servicesHidden: serviceHidden))
    }
}

//MARK:
extension MainServiceController: ServiceContollerDelegate {
    func serviceContollerClosed(contoller: ServiceContoller) {
        updateUI()
    }
}
