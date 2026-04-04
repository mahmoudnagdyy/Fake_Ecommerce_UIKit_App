//
//  ProductsService.swift
//  Fake_Ecommerce_UIKit
//
//  Created by Mahmoud Nagdy on 04/04/2026.
//

import Foundation



class ProductsService: ProductServiceProtocol {
    
    func getProducts() async throws -> [ProductModel] {
        guard let url = URL(string: "https://dummyjson.com/products") else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedData = try JSONDecoder().decode(ProductsResponse.self, from: data)
        return decodedData.products
    }
    
}
