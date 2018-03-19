//
//  BeersDetailsPresenter.swift
//  FractaIOS
//
//  Created by Vinicius Ricci on 14/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit


protocol BeersDetailsPresenterInput: BeersDetailsViewControllerOutput, BeersDetailsInteractorOutput {
    
}


class BeersDetailsPresenter: BeersDetailsPresenterInput {
    
    
   
    
    
    weak var view: BeersDetailsViewControllerInput!
    var interactor: BeersDetailsInteractorInput!
    
    
    
    func loadBeersImages() {
        
        self.interactor.loadbeersImages()
    }
    
    func sendLoadedBeerImage(_ image: UIImage) {
        
        self.view.setLoadImage(image: image)
    }
    
    func detailBeerModel(beer: Beer) {
        
        self.interactor.configureBeersModel(beer: beer)
        //self.view.beersFavorites(beers: beer)
    }
    
    func fetchName() {
        let beerName = self.interactor.beersNameDetails()
        self.view.setBeerName(beerName: beerName)
    }
    
    func fetchTagline(){
        let beerTagline = self.interactor.beersTaglineDetails()
        self.view.setBeerTagline(beerTagline: beerTagline)
    }
    
    func fetchDescription(){
        let beerDescription = self.interactor.beersDescriptionDetails()
        self.view.setBeerDescription(beerDescription: beerDescription)
    }
    
    func fetchBeersFavorites(beer: Beer) {
        
      // let beer = self.interactor.favoriteBeers()
       self.interactor.beersFavorites(beer: beer)
    }
    
    
    func isFavorited() {
        
        self.view.showAlertIsFavorite()
    }
    
    func fetchTeste() {

        let beers = self.interactor.favoriteBeers()
        
        self.view.showFavoriteBeers(beer: beers!)
        
        
    }
}
