//
//  Beer.swift
//  FractaIOS
//
//  Created by Vinicius Ricci on 14/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
class Beer : Object   {
    
   @objc dynamic var name: String = ""
   @objc dynamic var image_url : String = ""
   @objc dynamic var tagline: String = ""
   @objc dynamic var beerDescription: String = ""
   @objc dynamic var isFavorite : Bool = false

    
    
    
    
}
