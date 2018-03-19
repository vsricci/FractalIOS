//
//  FavoritesBeersViewController.swift
//  FractaIOS
//
//  Created by Vinicius Ricci on 17/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit
import RealmSwift
protocol FavoritesBeersViewControllerInput : class {
    
    func showWaitingView()
    func hideWatingView()
    func displayErrorView(_ errorMessage: String)
    func getTotalFavoriteBeersCount() -> NSInteger
}

protocol FavoritesBeersViewControllerOutput : class {
    
    func fetchFavoritesBeers() -> Results<Beer>
}





class FavoritesBeersViewController: UIViewController, FavoritesBeersViewControllerInput {

    @IBOutlet weak var tableView : UITableView!
    
    var presenter : FavoritesBeersViewControllerOutput!
    var favoritesBeers : Results<Beer>!
    var userDefaults = UserDefaults.standard
    
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
      
        self.favoritesBeers = self.presenter.fetchFavoritesBeers()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(back))

    }
    
    
    
    @objc func back() {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        FavoritesBeersAssembly.sharedInstance.configure(self)
    }
    
    func showWaitingView(){
        
        let alert = UIAlertController(title: nil, message: waitingKey, preferredStyle: .alert)
        alert.view.tintColor = UIColor.black
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = .gray
        loadingIndicator.startAnimating()
        
        alert.view.addSubview(loadingIndicator)
        self.navigationController?.present(alert, animated: true, completion: nil)
    }
    
    func hideWatingView(){
        self.dismiss(animated: true, completion: nil)
    }

    func displayErrorView(_ errorMessage: String) {
        
        let refreshAlert = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        refreshAlert.addAction(UIAlertAction(title: okKey, style: .default, handler: { (action) in
            
            refreshAlert.dismiss(animated: true, completion: nil)
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    func getTotalFavoriteBeersCount() -> NSInteger {
        
        return self.favoritesBeers.count
    }
    
   
  

}

extension FavoritesBeersViewController : UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
}

extension FavoritesBeersViewController: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesBeers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteBeerCell.defaultReuseIdentifier, for: indexPath) as! FavoriteBeerCell
        
        let item = favoritesBeers[indexPath.row]
        
        
        cell.beerName.text = item.name
        cell.beerDescription.text = item.tagline
        
        cell.beerImage.alpha = 0
        cell.beerImage.sd_setImage(with: URL(string: item.image_url)) { (image, error, cache, url) in
            
            cell.beerImage.image = image
            
            UIView.animate(withDuration: 0.2, animations: {
                
                cell.beerImage.alpha = 1.0
            })
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    
}


