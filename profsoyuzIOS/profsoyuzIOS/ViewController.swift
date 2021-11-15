//
//  ViewController.swift
//  profsoyuzIOS
//
//  Created by Andrew Tarasow on 15.11.2021.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var shopsTableView: UITableView!
    let shops: [Shop] = [Shop(name: "BugagaBar", distance: 32.3, logo: nil, address: "Новослободская 16А"),
                         Shop(name: "BugagaBar", distance: 32.3, logo: nil, address: "Новослободская 16А")]
    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sideMenuBtn.target = revealViewController()
                sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        
        self.shopsTableView.register(ShopTableViewCell.nib, forCellReuseIdentifier: ShopTableViewCell.identifier)

        // Update TableView with the data
        self.shopsTableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return shops.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShopTableViewCell.identifier,
                for: indexPath) as? ShopTableViewCell
        else {
            fatalError("xib doesn't exist")
        }
        
        let shop = shops[indexPath.section]
        cell.addressLabel.text = shop.address
        cell.distanceLabel.text = String.init(format: "%.2f КМ", shop.distance)
        cell.titleLabel.text = shop.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
