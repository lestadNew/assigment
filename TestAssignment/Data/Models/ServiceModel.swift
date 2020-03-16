//
//  ServiceModel.swift
//  TestAssignment
//
//  Created by Andrey Sokolov on 15.03.2020.
//  Copyright © 2020 Dmytro Kovryhin. All rights reserved.
//

import Foundation

class ServiceModel: NSObject, NSCoding, Codable {
    var conditions: AdditionalConditions
    var isShowsComment = false
    var isSelected = false
    var isHaveComments = false
    var commentaryConditions: String?
    
    init(conditions: AdditionalConditions,
         isShowsComment: Bool = false,
         isSelected: Bool = false,
         isHaveComments: Bool = false,
         commentaryConditions: String? = nil) {
        self.conditions = conditions
        self.isShowsComment = isShowsComment
        self.isSelected = isSelected
        self.isHaveComments = isHaveComments
        self.commentaryConditions = commentaryConditions
    }
    
    static func defaultsService(haveComments: Set<AdditionalConditions> = [.withSign, .animal],
                                hiddensService: (isHidden: Bool, servicesHidden: Set<AdditionalConditions>)?) -> [ServiceModel] {
        var defaultService: [ServiceModel] = []
        
        for type in AdditionalConditions.allCases {
            let service = ServiceModel(conditions: type)
            
            if haveComments.contains(type) {
                service.isHaveComments = true
            }
            
            if hiddensService?.isHidden == true, let serviceHiddens = hiddensService?.servicesHidden {
                if !serviceHiddens.contains(type) {
                    defaultService.append(service)
                }
            } else {
                defaultService.append(service)
            }
        }
        
        return defaultService
    }
    
    /// For NSCoding
    required convenience init?(coder aDecoder: NSCoder) {
        guard let unwrapConditions = aDecoder.decodeObject(forKey: "conditions") as? String, let conditions = AdditionalConditions(rawValue: unwrapConditions) else {
            return nil
        }
        
        let isShowsComment = aDecoder.decodeBool(forKey: "isShowsComment")
        let isSelected = aDecoder.decodeBool(forKey: "isSelected")
        let isHaveComments = aDecoder.decodeBool(forKey: "isHaveComments")
        let commentaryConditions = aDecoder.decodeObject(forKey: "commentaryConditions") as? String
        self.init(conditions: conditions, isShowsComment: isShowsComment, isSelected: isSelected, isHaveComments: isHaveComments, commentaryConditions: commentaryConditions)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(conditions.rawValue, forKey: "conditions")
        aCoder.encode(isShowsComment, forKey: "isShowsComment")
        aCoder.encode(isSelected, forKey: "isSelected")
        aCoder.encode(isHaveComments, forKey: "isHaveComments")
        aCoder.encode(commentaryConditions, forKey: "commentaryConditions")
    }
}
