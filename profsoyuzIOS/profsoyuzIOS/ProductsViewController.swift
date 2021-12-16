//
//  ProductsViewController.swift
//  profsoyuzIOS
//
//  Created by Andrew Tarasow on 13.12.2021.
//

import UIKit

class ProductsViewController: UIViewController {

    
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var productsTableView: UITableView!
    
    
    var products: [Product]! = [Product(id: 1, name: "Лагер", category:
                                            SubCategory(id: 1, category:
                                                            Category(id: 1, name: "пиво", image:"bear"),
                                                name: "Light"),
                                        price:"220 Р", description: "7%"),
                                Product(id: 1, name: "Лагер free", category:
                                                                        SubCategory(id: 1, category:
                                                                                        Category(id: 1, name: "пиво", image:"bear"),
                                                                            name: "Light"),
                                                                    price:"20 Р", description: "0%"),
                                Product(id: 2, name: "Темное не фильтрованное", category:
                                                                        SubCategory(id: 2, category:
                                                                                        Category(id: 1, name: "пиво", image:"bear"),
                                                                            name: "Dark"),
                                                                    price:"280 Р", description: "9.3%")
                                    ]
    var mainCategory: Category!
    var subCats: [SubCategory]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.productsTableView.register(SubCategoryTableViewCell.nib, forCellReuseIdentifier: SubCategoryTableViewCell.identifier)

        mainCategory = products.first?.category.category
        subCats = []
        for p in products {
            if subCats.contains(where: {$0.id == p.category.id}) {
                continue
            }
            subCats.append(p.category)
        }
        
        
        productsTableView.reloadData()
        // Do any additional setup after loading the view.
    }
    


}

extension ProductsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subCats.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SubCategoryTableViewCell.identifier,
                for: indexPath) as? SubCategoryTableViewCell
        else {
            fatalError("xib doesn't exist")
        }
        cell.products = products.filter{$0.category.id == subCats[indexPath.row].id}
        cell.subCatLabel.text = subCats[indexPath.row].name
        cell.subCAtsCountLabel.text = String(cell.products.count)
        cell.buttonView.setOnClickListener {
            cell.isActivated = !cell.isActivated
            cell.productTableView.reloadData()
            self.productsTableView.reloadData()
        }
        cell.productTableView.reloadData()
        return cell
    }
}

extension ProductsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
return 150
        //        guard let cell = productsTableView.cellForRow(at: indexPath) as? SubCategoryTableViewCell
//        else {
//            return 150
//        }
//        if !cell.isActivated {
//            return 70
//        }
//        return CGFloat(70 + cell.products.count * 40)
    }
    
}
