//
//  HomeTableViewCell.swift
//  iMovies
//
//  Created by Ibram on 5/19/20.
//  Copyright © 2020 Ibram. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    // outlets
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var moreLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
