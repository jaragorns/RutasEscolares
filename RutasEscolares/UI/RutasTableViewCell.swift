//
//  RutasTableViewCell.swift
//  RutasEscolares
//
//  Created by Jonathan Silva on 6/05/18.
//  Copyright © 2018 Jonathan Silva. All rights reserved.
//

import UIKit

class RutasTableViewCell: UITableViewCell {
    
    // MARK: Params & References
    
    @IBOutlet weak var iconRutas: UIImageView!
    @IBOutlet weak var titleRutas: UILabel!
    @IBOutlet weak var descriptionRutas: UILabel!
    @IBOutlet weak var dataView: UIView!
    
    // MARK: Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
