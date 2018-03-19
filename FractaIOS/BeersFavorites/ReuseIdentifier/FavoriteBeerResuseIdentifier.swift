//
//  FavoriteBeerResuseIdentifier.swift
//  FractaIOS
//
//  Created by Vinicius Ricci on 17/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit

public protocol FavoriteBeerIdentifierProtocol: class {
    
    //get identifier
    
    static var defaultReuseIdentifier: String { get }
}

public extension FavoriteBeerIdentifierProtocol where Self: UIView {
    
    static var defaultReuseIdentifier: String {
        
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
