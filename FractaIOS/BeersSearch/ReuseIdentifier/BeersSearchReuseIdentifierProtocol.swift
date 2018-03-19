//
//  BeersReuseIdentifier.swift
//  FractaIOS
//
//  Created by Vinicius Ricci on 16/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit

public protocol BeersSearchReuseIdentifierProtocol: class {
    
    //get identifier
    
    static var defaultReuseIdentifier: String { get }
}

public extension BeersSearchReuseIdentifierProtocol where Self: UIView {
    
    static var defaultReuseIdentifier: String {
        
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
