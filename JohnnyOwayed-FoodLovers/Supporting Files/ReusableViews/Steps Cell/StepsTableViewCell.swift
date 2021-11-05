//
//  TableViewCell.swift
//  JohnnyOwayed-FoodLovers
//
//  Created by Georges on 11/5/21.
//

import UIKit

class StepsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.label.font = .systemFont(ofSize: 24)
        self.textView.font = .systemFont(ofSize: 14)
    }
}
