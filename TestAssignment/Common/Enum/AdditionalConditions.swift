//
//  AdditionalConditions.swift
//  TestAssignment
//
//  Created by Dmytro Kovryhin on 11.03.2020.
//  Copyright © 2020 Dmytro Kovryhin. All rights reserved.
//

import UIKit

enum AdditionalConditions: String, CaseIterable, Codable {
    case baggage = "baggage"
    case animal = "animal"
    case conditioner = "conditioner"
    case courier = "courier_delivery"
    case engSpeaker = "english_speaker"
    case babyChair = "baby_chair"
    case nonSmoker = "non_smoker"
    case withSign = "with_sign"

    var title: String {
        switch self {
        case .baggage:
            return NSLocalizedString("orders_luggage", comment: "")
        case .animal:
            return NSLocalizedString("orders_animal", comment: "")
        case .conditioner:
            return NSLocalizedString("orders_conditioner", comment: "")
        case .courier:
            return NSLocalizedString("orders_courier", comment: "")
        case .engSpeaker:
            return NSLocalizedString("orders_english_speaker", comment: "")
        case .babyChair:
            return NSLocalizedString("orders_baby_chair", comment: "")
        case .nonSmoker:
            return NSLocalizedString("orders_no_smoke", comment: "")
        case .withSign:
            return NSLocalizedString("orders_meet_with_sign", comment: "")
        }
    }
}
