//
//  BeersSearchRouting.swift
//  FractaIOS
//
//  Created by Vinicius Ricci on 14/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit

protocol BeersSearchRouterInput: class {
    
    func navigationToBeerDetail()
    func passDataToNextScene(_ segue: UIStoryboardSegue)
    func navigationToFavoriteBeer()
    func passDataToShowFavoriteBeerScene(_ segue: UIStoryboardSegue)
}

class BeersSearchRouting : BeersSearchRouterInput {
    
    
    weak var viewController : BeersSearchViewController!
    
    
    //Navigation
    func navigationToBeerDetail() {
        viewController.performSegue(withIdentifier: "ShowBeerDetail", sender: nil)
        
    }
    
    func navigationToFavoriteBeer(){
        
        viewController.performSegue(withIdentifier: "ShowFavorite", sender: nil)
    }
    
    func passDataToNextScene(_ segue: UIStoryboardSegue) {
        
        if segue.identifier == "ShowBeerDetail" {
            passDataToShowBeerDetailScene(segue)
        }
        if segue.identifier == "ShowFavorite" {
            
            passDataToShowFavoriteBeerScene(segue)
        }
    }
    
    // navigate to another module
    func passDataToShowBeerDetailScene(_ segue: UIStoryboardSegue) {
        
        if let selectedIndexPath = viewController.tableView.indexPathForSelectedRow{
            let selectedBeer = viewController.beers[selectedIndexPath.row]
            let showDetailVC = segue.destination as! BeersDetailsViewController
            
            print(selectedBeer.name)
            showDetailVC.presenter.detailBeerModel(beer: selectedBeer)
            
        }
    }
    
    func passDataToShowFavoriteBeerScene(_ segue: UIStoryboardSegue) {
            let nav = segue.destination as! UINavigationController
            nav.topViewController as! FavoritesBeersViewController
    }
}
