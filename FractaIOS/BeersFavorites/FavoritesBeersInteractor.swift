//
//  FavoritesBeersInteractor.swift
//  FractaIOS
//
//  Created by Vinicius Ricci on 17/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit
import RealmSwift

protocol FavoritesBeersInteractorInput : class {
    
    func returnFavoritesBeers() -> Results<Beer>
}

protocol FavoritesBeersInteractorOutput : class {
    
    
}

class FavoritesBeersInteractor : FavoritesBeersInteractorInput{
    
    var presenter : FavoritesBeersPresenterInput!
    var realm = try! Realm()
    
    
    func returnFavoritesBeers() -> Results<Beer> {
        
       let beersFavorite = realm.objects(Beer.self)
        return beersFavorite
    }
    
    
}
