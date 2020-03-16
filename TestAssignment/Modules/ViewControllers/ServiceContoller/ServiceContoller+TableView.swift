//
//  ServiceContoller+TableView.swift
//  TestAssignment
//
//  Created by Andrey Sokolov on 15.03.2020.
//  Copyright © 2020 Dmytro Kovryhin. All rights reserved.
//

import UIKit

//MARK: - UITableViewDataSource
extension ServiceContoller: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ServiceCell
    
        if let service = services.getElement(at: indexPath.row) {
            cell.setModel(service: service)
            if indexPath == selectdCell {
                selectdCell = nil
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    cell.descriptionTextField.becomeFirstResponder()
                }
            }
        }
        
        return cell
    }
    
}

//MARK: - UITableViewDelegate
extension ServiceContoller: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let service = services.getElement(at: indexPath.row) {
            if service.isHaveComments {
                service.isShowsComment = !service.isShowsComment
                
                if !service.isSelected {
                    selectdCell = indexPath
                }
            }
            
            service.isSelected = !service.isSelected

            tableView.reloadIndexWithoutAnimation(indexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: sercionId) as? HeaderServiceView
        headerView?.headerLabel.text = Constant.Localized.ServiceContoller.headerLabel
        return headerView
    }
}
