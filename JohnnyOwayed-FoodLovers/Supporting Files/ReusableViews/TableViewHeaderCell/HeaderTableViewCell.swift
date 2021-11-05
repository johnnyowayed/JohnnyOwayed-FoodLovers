//
//  HeaderTableViewCell.swift
//  JohnnyOwayed-FoodLovers
//
//  Created by Georges on 11/5/21.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.label.font = .systemFont(ofSize: 24)
    }
}
