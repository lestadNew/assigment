//
//  Constant.swift
//  TestAssignment
//
//  Created by Andrey Sokolov on 15.03.2020.
//  Copyright © 2020 Dmytro Kovryhin. All rights reserved.
//

import UIKit

struct Constant {
    struct Localized {
        struct MainContoller {
            static let labelConstant = NSLocalizedString("constants_label_title", comment: "")
            static let labelTitle = NSLocalizedString("localized_label_title", comment: "")
            static let buttonTitle = NSLocalizedString("button_title", comment: "")
        }
        struct DoneButton {
            static let titleButton = NSLocalizedString("done_button_title", comment: "")
        }
        struct ServiceContoller {
            static let headerLabel = "Additional Service"
        }
    }
}
