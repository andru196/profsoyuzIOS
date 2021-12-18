//
//  ShopsViewController.swift
//  profsoyuzIOS
//
//  Created by Andrew Tarasow on 11.12.2021.
//

import UIKit

class ShopsViewController: ViewControllerWithData {
    
    @IBOutlet weak var tableViewView: UIView!
    
    var shop: Shop!
    var categories: [Category]!

    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoriesTableView: UITableView!
    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        dataController = (parent!.parent as! ViewControllerWithData).dataController
        shop = dataController.getShop()
        
        titleLabel.text = shop.name
        if let image = shop.background {
            let uiImage = UIImage(named: image)!
            
            titleView.backgroundColor = UIColor(patternImage: uiImage)
            
            titleView.layoutIfNeeded()
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: titleView.bounds.width, height: titleView.bounds.height))
            imageView.image = uiImage
            titleView.addSubview(imageView)
            
            imageView.addSubview(titleLabel)
            
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        //titleView.subviews.first?.contentMode = .scaleAspectFit
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let par = self.parent!.parent as? MainViewController else {
            return
        }
        dataController.selectedCategory(id: Int(categories[indexPath.section].id))
        par.showViewController(viewController: UINavigationController.self, storyboardId: "ProductNavId")
    }
    
}
