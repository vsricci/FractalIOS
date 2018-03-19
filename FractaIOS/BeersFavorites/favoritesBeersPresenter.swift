//
//  favoritesBeersPresenter.swift
//  FractaIOS
//
//  Created by Vinicius Ricci on 17/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import Foundation
import RealmSwift
protocol FavoritesBeersPresenterInput : FavoritesBeersViewControllerOutput, FavoritesBeersInteractorOutput {
    
    
}



class FavoritesBeersPresenter: FavoritesBeersPresenterInput {
    
    
   
    var interactor : FavoritesBeersInteractorInput!
    var view : FavoritesBeersViewControllerInput!
    
    func fetchFavoritesBeers() -> Results<Beer> {
        
        return self.interactor.returnFavoritesBeers()
    }
    
    func serviceError(_ error: NSError){
        self.view.displayErrorView(defaultErrorMessage)
    }
    
    
    
}
