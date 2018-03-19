//
//  BeersDetailsInteractor.swift
//  FractaIOS
//
//  Created by Vinicius Ricci on 16/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit
import RealmSwift
protocol BeersDetailsInteractorInput : class {
    
    func configureBeersModel(beer: Beer)
    func beersNameDetails() -> String
    func beersTaglineDetails() -> String
    func beersDescriptionDetails() -> String
    func loadbeersImages()
    func beersFavorites(beer: Beer)
    func favoriteBeers() -> Beer?
    
}

protocol BeersDetailsInteractorOutput : class {
    
    func sendLoadedBeerImage(_ image: UIImage)
    
    
}

class BeersDetailsInteractor: BeersDetailsInteractorInput {
   
    
    
    
    
    
    var presenter : BeersDetailsInteractorOutput!
    var beer : Beer?
     var beers = [Beer]()
    var beersDataManager : APIDataManager!
    
    
    func loadbeersImages() {
        
        APIDataManager.sharedResponse.loadImageFromUrl(URL(string: (self.beer?.image_url)!) as! NSURL) { (image, error) in
            
            if let image = image {
                
                self.presenter.sendLoadedBeerImage(image)
            }
        }
    }
    
    func configureBeersModel(beer: Beer){
        
        self.beer = beer
        
        
        self.beers.append(beer)
       
    }
    
    
    func beersNameDetails() -> String {
        
        if let name = self.beer?.name {
            
            return name
        }
        return ""
    }
    
    func beersTaglineDetails() -> String {
        
        if let tagline = self.beer?.tagline {
            
            return tagline
        }
        return ""
    }
    
    func beersDescriptionDetails() -> String {
        
        if let description = self.beer?.beerDescription {
            
            return description
        }
        return ""
    }
    
    func favoriteBeers() -> Beer? {
        
        if let favoriteBeers = self.beer {
            
        return favoriteBeers
        }
       return nil
    }
    
    func beersFavorites(beer: Beer){
       
        let realm = try! Realm()
       
        do {
            try!
                realm.write {
                    realm.add(beer)
            }
            
        } catch {
            
            print("\(error)")
        }
        
        
    
        
    }
    
    
}
