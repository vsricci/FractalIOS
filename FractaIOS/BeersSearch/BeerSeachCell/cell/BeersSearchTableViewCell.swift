//
//  BeersSearchCellTableViewCell.swift
//  FractaIOS
//
//  Created by Vinicius Ricci on 14/03/2018.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit

class BeersSearchTableViewCell: UITableViewCell, BeersSearchReuseIdentifierProtocol {
    
    @IBOutlet weak var beerImage : UIImageView!
    @IBOutlet weak var beerName : UILabel!
    @IBOutlet weak var beerDescription: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       // self.contentView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        self.contentView.tintColor = UIColor(white: 0.95, alpha: 1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
