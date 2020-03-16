//
//  ServiceContoller.swift
//  TestAssignment
//
//  Created by Andrey Sokolov on 15.03.2020.
//  Copyright © 2020 Dmytro Kovryhin. All rights reserved.
//

import UIKit

protocol ServiceContollerDelegate: class {
    func serviceContollerClosed(contoller: ServiceContoller)
}

class ServiceContoller: BaseController {
    
    private lazy var closeView: CloseButton = {
        var view = CloseButton(frame: CGRect(x: 0, y: 0, width: 40, height: 50))
        return view
    }()

    private lazy var doneView: DoneButtonView = {
        var view = DoneButtonView(frame: CGRect(x: 0, y: 0, width: 40, height: 50))
        return view
    }()
    
    let cellId: String = String(describing: ServiceCell.self)
    let sercionId: String = String(describing: HeaderServiceView.self)
    
    var selectdCell: IndexPath?
    var services: [ServiceModel] = []
    var hiddenServiceIndex: (isHidden: Bool, servicesHidden: Set<AdditionalConditions>)?
    
    weak var delegate: ServiceContollerDelegate?
    
    //MARK: - IBOutlet
    @IBOutlet private weak var tableView: UITableView!
    

    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    //MARK: - Private methods
    private func setup() {
        
        //TODO: - Можно было без defaults, не знаю чего добавил, чтоб менять модель надо чистить Defaults (например при открытии первого экрана) для теста в Appdelegat(sceen delegate ) всунуть
        services = ArchiveService.standart.servicesModels.count != 0 ? ArchiveService.standart.servicesModels : ServiceModel.defaultsService(hiddensService: hiddenServiceIndex)
        
        tableView.register(UINib(nibName: sercionId, bundle: nil),
        forHeaderFooterViewReuseIdentifier: sercionId)
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.estimatedSectionHeaderHeight = 100
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        setupCloseButton()
        setupDoneButton()
        tableView.reloadData()
    }
    
    private func setupCloseButton() {
        let backButton = UIBarButtonItem (customView: closeView)
        closeView.delegate = self
        self.navigationItem.leftBarButtonItem = backButton
    }
       
    private func setupDoneButton() {
        let backButton = UIBarButtonItem (customView: doneView)
        doneView.delegate = self
        self.navigationItem.rightBarButtonItem = backButton
    }
    
    private func closeAndSave() {
        ArchiveService.standart.servicesModels = services
        delegate?.serviceContollerClosed(contoller: self)
        dismiss(animated: true)
    }
}
 
//MARK: - CloseButtonDelegate
extension ServiceContoller: CloseButtonDelegate {
    func closeButton(view: CloseButton) {
        closeAndSave()
    }
}

//MARK: - DoneButtonViewDelegate
extension ServiceContoller: DoneButtonViewDelegate {
    func doneButtonViewApply(view: DoneButtonView) {
        closeAndSave()
    }
}
