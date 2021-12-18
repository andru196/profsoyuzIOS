//
//  ShopTableViewCell.swift
//  profsoyuzIOS
//
//  Created by Andrew Tarasow on 15.11.2021.
//

import UIKit

class ShopTableViewCell: UITableViewCell {

    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var icoImageView: UIImageView!
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.cornerRadius = 30
        contentView.layer.cornerRadius = 30
        
        icoImageView.layer.borderWidth = 0
        icoImageView.layer.masksToBounds = false
        icoImageView.layer.borderColor = UIColor.black.cgColor
        icoImageView.layer.cornerRadius = icoImageView.frame.height/2
        icoImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
