//
//  MyCell.swift
//  DesafioStone
//
//  Created by Rodrigo Filomeno on 22/10/17.
//  Copyright © 2017 Rodrigo Filomeno. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellPrice: UILabel!
    @IBOutlet weak var cellSeller: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
