//
//  ProductModel.swift
//  Fake_Ecommerce_UIKit
//
//  Created by Mahmoud Nagdy on 04/04/2026.
//

import Foundation


struct ProductModel: Codable, Identifiable {
    let id: Int
    let title, description, category: String
    let price, rating: Double
    let stock: Int
    let brand: String?
    let images: [String]
}


struct ProductsResponse: Codable {
    let products: [ProductModel]
}
