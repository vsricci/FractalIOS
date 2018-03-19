//
//  FavoritesBeersAssembly.swift
//  FractaIOS
//
//  Created by Vinicius Ricci on 17/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit

class FavoritesBeersAssembly {
    
    static let sharedInstance = FavoritesBeersAssembly()
    
    func configure(_ viewController : FavoritesBeersViewController) {
        
        let presenter = FavoritesBeersPresenter()
        let interactor = FavoritesBeersInteractor()
        let router = FavoritesBeersRouting()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        presenter.interactor =  interactor
        
    }
}
