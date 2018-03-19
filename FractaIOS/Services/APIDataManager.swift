//
//  APIDataManager.swift
//  FractaIOS
//
//  Created by Vinicius Ricci on 14/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import Foundation
import Alamofire
import SDWebImage
import ObjectMapper
protocol BeersListProtocol : class {
    
    func beersList(_ url: String, page: Int, clousure: @escaping (Beer?, Int?) -> Void, failure: @escaping (NSError?, Int?) -> Void)
}

class APIDataManager: BeersListProtocol  {
    
    static let sharedResponse = APIDataManager()
    let manager = Alamofire.SessionManager.default
    
    func beersList(_ url: String, page: Int, clousure: @escaping (Beer?, Int?) -> Void, failure: @escaping (NSError?, Int?) -> Void) {
        
        let urlFull = "\(url)?page=\(page)"
        manager.request(URL(string: urlFull)!, method: .get, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200..<402).responseJSON { (response) in
            
            let status = response.response?.statusCode
            
            switch response.result {
                
            case .success:
                
                guard let responseJSON = response.result.value as? [[String:Any]] else {return}
              //  let result = Mapper<Beer>().mapArray(JSONObject: responseJSON)
                
                for results in responseJSON {
                    
                    guard let name = results["name"] as? String else {return}
                    guard let image = results["image_url"] as? String else {return}
                    guard let tagline = results["tagline"] as? String else {return}
                    guard let description = results["description"] as? String else {return}
                    
                    let beers = Beer()
                    beers.name = name
                    beers.image_url = image
                    beers.tagline = tagline
                    beers.beerDescription = description
                    beers.isFavorite = false
                    
                     clousure(beers, status)
                    
                }
            
            
            case .failure(let error):
                
                    print(error)
                    failure(error as NSError, status)
                
            }
        }
        
    }
    
    func loadImageFromUrl(_ url: NSURL, clousure: @escaping (UIImage?, NSError?) -> Void) {
        
        
        SDWebImageManager.shared().imageDownloader?.downloadImage(with: url as URL, options: .continueInBackground, progress: nil, completed: { (image, data, error, finished) in
            
            if ((image != nil) && finished) {
                clousure(image, error as? NSError)
                
            }
            
        })
       
    }
    
}
