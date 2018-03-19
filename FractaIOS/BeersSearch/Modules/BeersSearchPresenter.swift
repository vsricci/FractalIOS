//
//  BeersSechPresenter.swift
//  FractaIOS
//
//  Created by Vinicius Ricci on 14/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit

protocol BeersSearchPresenterInput: BeersSearchViewControllerOutput, BeersSearchInteractorOutput {
    
}

class BeersSearchPresenter: BeersSearchPresenterInput {
  
    
    var view: BeersSearchViewControllerInput!
    var interactor: BeersSearchInteractorInput!
    var router : BeersSearchRouterInput!
    
    
    func list(_ url: String, page: Int) {
        
        
        if view.getTotalBeersCount() == 0 {
            
            view.showWaitingView()
        }
        interactor?.BeersSearchRequest(url, page: page)
    }
    
    func serviceError(_ error: NSError){
        self.view.displayErrorView(errorMessage)
    }
    
    func providedBeers(_ beers : Beer, totalPages: NSInteger){
        self.view.hideWatingView()
        
        self.view.displayFetchedBeers(beers, totalPages: totalPages)
        
    }
    
    func goToBeerDetailScreen() {
        
        self.router.navigationToBeerDetail()
    }
    
     func passDataToNextScene(_ segue: UIStoryboardSegue) {
        
        if segue.identifier == "ShowFavorite" {
            self.router.passDataToShowFavoriteBeerScene(segue)
        }
        else {
            self.router.passDataToNextScene(segue)
        }
        
        
    }
    
    func goToBeerFavoriteScreen() {
        
        self.router.navigationToFavoriteBeer()
    }
    
    
    
}
