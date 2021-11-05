//
//  FoodItemCollectionViewCell.swift
//  JohnnyOwayed-FoodLovers
//
//  Created by Georges on 11/5/21.
//

import UIKit

class FoodItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image_ImageView:UIImageView!
    @IBOutlet weak var title_Label: UILabel!
    @IBOutlet weak var subtitle1_Label: UILabel!
    @IBOutlet weak var subtitle2_Label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.image_ImageView.contentMode = .scaleAspectFill
        
        self.title_Label.textColor = .blue
        self.title_Label.font = .systemFont(ofSize: 16)
        self.title_Label.numberOfLines = 0
        
        self.subtitle1_Label.font = .systemFont(ofSize: 12)
        self.subtitle1_Label.numberOfLines = 0
        self.subtitle1_Label.textColor = .gray
        
        self.subtitle2_Label.font = .systemFont(ofSize: 12)
        self.subtitle2_Label.numberOfLines = 0
        self.subtitle2_Label.textColor = .gray
    }

}
