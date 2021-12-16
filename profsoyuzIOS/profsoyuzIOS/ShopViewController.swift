//
//  ShopsViewController.swift
//  profsoyuzIOS
//
//  Created by Andrew Tarasow on 11.12.2021.
//

import UIKit

class ShopsViewController: UIViewController {
    
    @IBOutlet weak var tableViewView: UIView!
    
    var shop: Shop! = Shop(name: "BugagaBar",
                           distance: 32.3,
                           logo: nil,
                           address: "Новослободская 16А",
                           background: "mandy",
                           products: [Product(id: 1, name: "Лагер", category:
                                                SubCategory(id: 1, category: Category(id: 1, name: "пиво", image: "bear"), name: "лагер"), price:"", description: "")])
    @IBOutlet weak var titleView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var categories: [Category]!
    @IBOutlet weak var categoriesTableView: UITableView!
    
    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = shop.name
        if let image = shop.background {
            titleView.backgroundColor = UIColor(patternImage: UIImage(named: image)!)
        }
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)

        self.categoriesTableView.register(CategoryTableViewCell.nib, forCellReuseIdentifier: CategoryTableViewCell.identifier)
        
        var tmp:[Category] = []
        for p in shop.products! {
            if tmp.contains(where: {$0.id == p.category.category.id}) {
                continue
            }
            tmp.append(p.category.category)
        }
        categories = tmp
    
        self.categoriesTableView.reloadData()
        tableViewView.layer.cornerRadius = 30
    }
}

extension ShopsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier,
                for: indexPath) as? CategoryTableViewCell
        else {
            fatalError("xib doesn't exist")
        }
        cell.setCategory(categories[indexPath.section])
        return cell
    }
    
    
}

extension ShopsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
