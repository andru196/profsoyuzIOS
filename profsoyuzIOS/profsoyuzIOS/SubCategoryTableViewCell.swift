//
//  SubCategoryTableViewCell.swift
//  profsoyuzIOS
//
//  Created by Andrew Tarasow on 12.12.2021.
//

import UIKit

class SubCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var subCatLabel: UILabel!
    @IBOutlet weak var subCAtsCountLabel: UILabel!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var productTableView: UITableView!
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    var products: [Product]!
    private var _isActive: Bool = true
    var isActivated: Bool {
        get {
            return _isActive
        }
        set (valuew) {
            _isActive = valuew
            if valuew {
                productTableView.frame.size.height = CGFloat((products?.count ?? 0) * 40)
//                productTableView.frame = CGRect(x: 0 , y: self.frame.height * 0.7, width: self.frame.width, height: self.frame.height * 0.3)
            } else {
                productTableView.frame.size.height = 1
                
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.productTableView.register(ProductTableViewCell.nib, forCellReuseIdentifier: ProductTableViewCell.identifier)
        
        productTableView.reloadData()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension SubCategoryTableViewCell : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isActivated {
            return products?.count ?? 0
        }
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier,
                for: indexPath) as? ProductTableViewCell
        else {
            fatalError("xib doesn't exist")
        }
        let product = products[indexPath.row]
        cell.nameLabel.text = product.name
        cell.descriptionLabel.text = product.description
        cell.buyButton.titleLabel?.text = product.price
        return cell
    }
}

extension SubCategoryTableViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isActivated {
            return 50
        }
        return 1
    }
    
}



extension UIView {
     
     func setOnClickListener(action :@escaping () -> Void){
        let tapRecogniser = ClickListener(target: self, action: #selector(onViewClicked(sender:)))
        tapRecogniser.onClick = action
        self.addGestureRecognizer(tapRecogniser)
     }
     
     @objc func onViewClicked(sender: ClickListener) {
        if let onClick = sender.onClick {
            onClick()
        }
     }
     
}

class ClickListener: UITapGestureRecognizer {
    var onClick : (() -> Void)? = nil
}
