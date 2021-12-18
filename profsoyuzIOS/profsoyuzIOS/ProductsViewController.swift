//
//  ProductsViewController.swift
//  profsoyuzIOS
//
//  Created by Andrew Tarasow on 13.12.2021.
//

import UIKit

class ProductsViewController: ViewControllerWithData {

    
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var productsTableView: UITableView!
    
    
    var products: [Product]!
    var mainCategory: Category!
    var subCats: [SubCategory]!
    var subCatsChildsVisible: [Int: [Int:Bool]]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataController = (parent!.parent as! ViewControllerWithData).dataController
        products = dataController.getSelectedProduct()
        
        self.productsTableView.register(SubCategoryTableViewCell.nib, forCellReuseIdentifier: SubCategoryTableViewCell.identifier)

        mainCategory = products.first?.category.category
        subCats = []
        subCatsChildsVisible = [:]
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
            print("\(cell.subCatLabel.text!) pressed")
            if self.subCatsChildsVisible[indexPath.section] == nil {
                self.subCatsChildsVisible[indexPath.section] = [:]
            }
            if self.subCatsChildsVisible[indexPath.section]![indexPath.row] == nil {
                self.subCatsChildsVisible[indexPath.section]![indexPath.row] = true
            } else {
                self.subCatsChildsVisible[indexPath.section]![indexPath.row] = !self.subCatsChildsVisible[indexPath.section]![indexPath.row]!
            }
            let isActive = self.subCatsChildsVisible[indexPath.section]![indexPath.row]!
            if isActive {
                self.productsTableView.reloadRows(at: [indexPath], with: .bottom)
            } else {
                self.productsTableView.reloadRows(at: [indexPath], with: .top)
            }

        }
        if let isActive = self.subCatsChildsVisible[indexPath.section]?[indexPath.row] {
            cell.productTableView.isHidden = !isActive
            cell.isActivated = isActive
            cell.productTableView.reloadData()
        }
        print("\(cell.subCatLabel.text!) isHidden:\(cell.productTableView.isHidden)")
        return cell
    }
}

extension ProductsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let products = products.filter{$0.category.id == subCats[indexPath.row].id}
        return CGFloat(70 + ((subCatsChildsVisible[indexPath.section]?[indexPath.row] ?? false) ? products.count * 50 : 0))
    }
    
}
