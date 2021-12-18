//
//  ProductTableViewCell.swift
//  profsoyuzIOS
//
//  Created by Andrew Tarasow on 12.12.2021.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    var viewC: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func buyButtonTaped(_ sender: Any) {
        let alert = UIAlertController(title: "Сервис временно не доступен", message: "Пожалуйста позовите официанта, сейчас нельзя сделать заказ через приложение☹️", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            print("aga")
        }))
        viewC.present(alert, animated: true, completion: nil)

    }
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
}
