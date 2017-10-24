//
//  TransacaoCell.swift
//  DesafioStone
//
//  Created by Rodrigo Filomeno on 24/10/17.
//  Copyright © 2017 Rodrigo Filomeno. All rights reserved.
//

import UIKit

class TransacaoCell: UITableViewCell {
    
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var cartaoLabel: UILabel!
    
    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var valorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
