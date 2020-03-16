//
//  ServiceRouter.swift
//  TestAssignment
//
//  Created by Andrey Sokolov on 15.03.2020.
//  Copyright © 2020 Dmytro Kovryhin. All rights reserved.
//

import UIKit

class ServiceRouter: BaseRouter {
    //TODO: Вариант если не использовать Defaults, а временого сохранения
    func pushServiceContoller<C>(delegate: C, hiddenServiceIndex: (isHidden: Bool, servicesHidden: Set<AdditionalConditions>)) where C: ServiceContollerDelegate {
        let controller = ServiceContoller()
        controller.delegate = delegate
        controller.hiddenServiceIndex = hiddenServiceIndex
        let nc = UINavigationController(rootViewController: controller)
        present(controller: nc)
    }
}
