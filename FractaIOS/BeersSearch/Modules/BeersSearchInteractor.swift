//
//  BeersSearchInteractor.swift
//  FractaIOS
//
//  Created by Vinicius Ricci on 14/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import Foundation

protocol BeersSearchInteractorInput : class {
    
    func BeersSearchRequest(_ url: String, page: Int)
}

protocol BeersSearchInteractorOutput : class {
    func providedBeers(_ photos : Beer, totalPages: NSInteger)
    func serviceError(_ error: NSError)
}



class BeersSearhInteractor: BeersSearchInteractorInput  {

    weak var presenter : BeersSearchInteractorOutput!
    var beersDataManager : APIDataManager!
    
    func BeersSearchRequest(_ url: String, page: Int) {
        
        
        APIDataManager.sharedResponse.beersList(url, page: page, clousure: { (beers, status) in
            
            self.presenter.providedBeers(beers!, totalPages: page)
            
        }) { (error, status) in
            
            self.presenter.serviceError(error!)
        }
    }
}
