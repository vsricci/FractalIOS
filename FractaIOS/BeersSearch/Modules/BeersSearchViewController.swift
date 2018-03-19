//
//  BeersSearchViewController.swift
//  FractaIOS
//
//  Created by Vinicius Ricci on 14/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import RealmSwift
protocol BeersSearchViewControllerInput {

    func displayFetchedBeers(_ beers : Beer, totalPages: NSInteger)
    func displayErrorView(_ errorMessage: String)
    func showWaitingView()
    func hideWatingView()
    func getTotalBeersCount() -> NSInteger
    
    
}

protocol BeersSearchViewControllerOutput {
    
    func list(_ url: String, page: Int)
    func goToBeerDetailScreen()
    func goToBeerFavoriteScreen()
    func passDataToNextScene(_ segue: UIStoryboardSegue)
}





class BeersSearchViewController : UIViewController, BeersSearchViewControllerInput {
    

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar : UISearchBar!
    var presenter : BeersSearchViewControllerOutput!
    var beers = [Beer]()
    var filterBeers = [Beer]()
    var currentPage = 1
    var totalPages = 1
    var rowsCount = 25
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.removeObserver(self)
        
        
        
        presenter.list(urlBeers, page: currentPage)
        
        
        
        searchBar.delegate = self
        searchBar.placeholder = "Search Beers:"
        
        //self.navigationItem.titleView = searchBar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Ver Favoritos", style: .plain, target: self, action: #selector(nextFavorite))
        
//
//
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        BeersSearchAssembly.shredInstance.configure(self)
    }
    
    
    
    func displayFetchedBeers(_ beers: Beer, totalPages: NSInteger) {
        
            self.beers.append(beers)
            self.filterBeers = self.beers
            self.totalPages = totalPages
            
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
            }
        
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
    
    func getTotalBeersCount() -> NSInteger {
        
        return self.beers.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        presenter.passDataToNextScene(segue)
    }

    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchBar.text?.isEmpty ?? true
    }
    
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        self.filterBeers = self.beers.filter({( beer : Beer) -> Bool in
            return (beer.name.lowercased().contains(searchText.lowercased()))
        })
        
        tableView.reloadData()
    }
    
    @objc func nextFavorite(){
        
        self.presenter.goToBeerFavoriteScreen()
    }

}


extension BeersSearchViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
     
            
            return beersSearchItemCell(tableView, cellForItemAt: indexPath as NSIndexPath )
            

    }
    
    func beersSearchItemCell(_ tableView: UITableView, cellForItemAt indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BeersSearchTableViewCell.defaultReuseIdentifier, for: indexPath as IndexPath) as! BeersSearchTableViewCell
        
        let item = filterBeers[indexPath.row]
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
    
    func beersSearchLoadingCell(_ tableView: UITableView, cellForItemAt indexPath: NSIndexPath) -> UITableViewCell{
        
         let cell = tableView.dequeueReusableCell(withIdentifier: BeersSearchLoadingTableViewCell.defaultReuseIdentifier, for: indexPath as IndexPath) as! BeersSearchLoadingTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.presenter.goToBeerDetailScreen()
       // print("teste")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
            
            let lastSectionIndex = tableView.numberOfSections - 1
            let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
            if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
                
                
                let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
                spinner.startAnimating()
                
                
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0, execute: {
                    print(self.rowsCount + self.beers.count)
                    spinner.stopAnimating()
                    
                    print("\(self.rowsCount)" + " " +  "\(self.beers.count)")
                    if self.self.rowsCount > self.beers.count {
                        
                        
                        self.currentPage += 1
                        self.presenter.list(urlBeers, page: self.currentPage)
                        
                        spinner.stopAnimating()
                        
                        print("\(self.rowsCount)" + " " +  "\(self.beers.count)")
                        let label  = UILabel()
                        
                        label.text = "Não há mais cervejas"
                        
                        label.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(35))
                        label.font = label.font.withSize(12)
                        label.textAlignment = .center
                        self.tableView?.tableFooterView = label
                        self.tableView?.tableFooterView?.isHidden = false
                    }
                    else {
                        self.rowsCount += 25
                        self.tableView?.reloadData()
                    }
                    
                    
                })
                
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
                self.tableView?.tableFooterView = spinner
                self.tableView?.tableFooterView?.isHidden = false
                
                
            }
        
    }

}

extension BeersSearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if rowsCount > filterBeers.count {
            
            return filterBeers.count
        }
        else{
            return rowsCount
        }
        
    }
    
}

extension BeersSearchViewController: UISearchBarDelegate {
  
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text! == "" {
            self.filterBeers = self.beers
        } else {
            // Filter the results
            self.filterBeers = self.beers.filter {
                ($0.name.lowercased().contains(searchBar.text!.lowercased())) }
        }
        
        self.tableView.reloadData()
    }
    
    
}




