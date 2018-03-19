//
//  BeersDetailsViewController.swift
//  FractaIOS
//
//  Created by Vinicius Ricci on 14/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit
import RealmSwift

protocol BeersDetailsViewControllerInput: class {
   
    func setBeerName(beerName: String)
    func setBeerTagline(beerTagline: String)
    func setBeerDescription(beerDescription: String)
    func setLoadImage(image: UIImage)
    
    func showAlertIsFavorite()
    func showFavoriteBeers(beer: Beer)
    
}

protocol BeersDetailsViewControllerOutput: class {

    func detailBeerModel(beer: Beer)
    func fetchName()
    func fetchTagline()
    func fetchDescription()
    func loadBeersImages()
    func fetchBeersFavorites(beer: Beer)
    func fetchTeste()
    func isFavorited()
    
}

class BeersDetailsViewController : UIViewController, BeersDetailsViewControllerInput{
    
    
    
    
    @IBOutlet weak var beerImageUIM: UIImageView!
    @IBOutlet weak var beerNameUL: UILabel!
    @IBOutlet weak var beerTaglineUL: UILabel!
    @IBOutlet weak var beerDescriptionUL : UILabel!
    
    var beersNames = [String]()
    var beersImages : [String] = []
    var beersDescriptions : [String] = []
    var beersTaglines: [String] = []
    let realm = try! Realm()
   
    var lista = [String]()
    var presenter : BeersDetailsViewControllerOutput!
    var favoriteBeers = [Beer]()
    var favoriteBeer : Beer!
    var userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Beers Details"
        print(self.presenter.fetchName())
        self.presenter.fetchTagline()
        self.presenter.fetchDescription()
        self.presenter.loadBeersImages()
       
        
        
    }
    
    
    
    @IBAction func favoriteBeer(_ sender: UIButton){
        
        self.presenter.fetchTeste()
        self.presenter.isFavorited()
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        BeersDetailsAssembly.sharedInstance.configure(self)
    }
    
   
    
    func setLoadImage(image: UIImage){
        
        self.beerImageUIM.image = image
        
    }
    
    func setBeerName(beerName: String) {
        
        self.beerNameUL.text = beerName
    }
    
    func setBeerTagline(beerTagline: String) {
        
        self.beerTaglineUL.text = beerTagline
    }
    
    func setBeerDescription(beerDescription: String) {
        
        self.beerDescriptionUL.text = beerDescription
    }
    
    
    
    
    func showAlertIsFavorite() {
        
        let alert = UIAlertController(title: "Sucesso!!!", message: "Esta cerveja foi favoritada", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alertAction) in
            
            alert.dismiss(animated: true, completion: nil)
        }))
    
        self.present(alert, animated: true, completion: nil)
    }
    
    func showFavoriteBeers(beer: Beer) {
        
        presenter.fetchBeersFavorites(beer: beer)
        

    }
    
    
  
}
