//
//  BeersDetailsAssembly.swift
//  FractaIOS
//
//  Created by Vinicius Ricci on 14/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit

class BeersDetailsAssembly {
    
   static let sharedInstance = BeersDetailsAssembly()
    
    func configure(_ viewController : BeersDetailsViewController) {
        
        let manager = APIDataManager()
        let interactor = BeersDetailsInteractor()
        let presenter = BeersDetailsPresenter()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        presenter.interactor =  interactor
        interactor.beersDataManager = manager
    }
}
