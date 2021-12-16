//
//  CategoryTableViewCell.swift
//  profsoyuzIOS
//
//  Created by Andrew Tarasow on 11.12.2021.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    var category: Category!
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.layer.cornerRadius = 30
        contentView.layer.cornerRadius = 30
        // Configure the view for the selected state
    }
    
    func setCategory(_ category: Category) {
        self.category = category
        nameLabel.text = category.name
        if let image = category.image {
            contentView.backgroundColor = UIColor(patternImage: UIImage(named: image)!)
        }
    }
    
}

