//
//  DataController.swift
//  profsoyuzIOS
//
//  Created by Andrew Tarasow on 18.12.2021.
//

import Foundation

class DataController {
    lazy var shops : [Shop] = {
        let bearCat = Category(id: 1, name: "пиво", image:"bear")
        let bearSubCat1 = SubCategory(id: 1, category: bearCat, name: "Light")
        let bearSubCat2 = SubCategory(id: 2, category: bearCat, name: "Dark")
        let bp1 = Product(id: 1, name: "Лагер", category: bearSubCat1, price:"220 Р", description: "7%")
        let bp2 = Product(id: 2, name: "Лагер free", category: bearSubCat1, price:"20 Р", description: "0%")
        let bp3 = Product(id: 3, name: "Темное не фильтрованное", category: bearSubCat2,
                                            price:"280 Р", description: "9.3%")
        let shop1 = Shop(name: "BugagaBar",
                         distance: 32.3,
                         logo: nil,
                         address: "Новослободская 16А",
                         background: "mandy",
                         products: [bp1, bp2, bp3])
        
        let alcoCat = Category(id: 2, name: "Крепкие напитки", image:"whisky")
        let alcoSubCat1 = SubCategory(id: 4, category: alcoCat, name: "Виски")
        let alcoSubCat2 = SubCategory(id: 5, category: alcoCat, name: "Джин")
        let alcoSubCat3 = SubCategory(id: 6, category: alcoCat, name: "Водка")
        let ap1 = Product(id: 4, name: "Jim Apple", category: alcoSubCat1, price:"220 Р", description: "40ml")
        let ap2 = Product(id: 5, name: "Jim Peach", category: alcoSubCat1, price:"230 Р", description: "40ml")
        let ap3 = Product(id: 6, name: "Beefeater", category: alcoSubCat2, price:"200 Р", description: "40ml")
        let ap4 = Product(id: 7, name: "Barrister", category: alcoSubCat2, price:"210 Р", description: "40ml")
        let ap5 = Product(id: 8, name: "Белуга", category: alcoSubCat3, price:"200 Р", description: "40ml")
        let shop2 = Shop(name: "BarDuck",
                                  distance: 32.3,
                                  logo: "ducks",
                                  address: "Новослободская 16А",
                                  background: "ducks",
                                products: [ap1, ap2, ap3, ap4, ap5])
        
        
        let vineCat = Category(id: 3, name: "Вина", image:"vine")
        let vineSubCat1 = SubCategory(id: 7, category: vineCat, name: "Красное")
        let vp = Product(id: 8, name: "Bodegas Contador", category: vineSubCat1, price:"3710 Р", description: "\"Contador\", Rioja DOCa, 2005 750ml")
        
        let shop3 = Shop(name: "DeadSkull",
                                  distance: 32.3,
                                  logo: "skulls",
                                  address: "Новослободская 16А",
                                  background: "skulls",
                                products: [ap1, ap2, ap3, ap4, ap5, bp1, bp2, bp3, vp])
        
        return [shop1, shop2, shop3]
    }()

    private var selectedShop: Int = 0
    private var selectedCategory: Int = 0
    
    public func selectShop(i: Int) {
        selectedShop = i
    }

    public func selectedCategory(id: Int) {
        selectedCategory = id
    }
    
    public func getShop() -> Shop {
        return shops[selectedShop]
    }
    
    public func getSelectedProduct() -> [Product] {
        return (shops[selectedShop].products!.filter({$0.category.category.id == selectedCategory}))
    }
    
         
}
