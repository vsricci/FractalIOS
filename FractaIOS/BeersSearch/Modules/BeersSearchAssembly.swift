//
//  BeersSeachAssembly.swift
//  FractaIOS
//
//  Created by Vinicius Ricci on 14/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import Foundation


class BeersSearchAssembly {
    
    static let shredInstance = BeersSearchAssembly()
    
    func configure(_ viewController: BeersSearchViewController) {
        
        let manager = APIDataManager()
        let interactor = BeersSearhInteractor()
        let presenter = BeersSearchPresenter()
        let router = BeersSearchRouting()
        router.viewController = viewController
        presenter.router = router
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        presenter.interactor = interactor
        interactor.beersDataManager = manager
    }
}
