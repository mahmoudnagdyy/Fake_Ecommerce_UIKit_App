//
//  ProductsViewModel.swift
//  Fake_Ecommerce_UIKit
//
//  Created by Mahmoud Nagdy on 04/04/2026.
//

import Foundation



class ProductsViewModel {
    
    var products: [ProductModel] = []
    var filteredProducts: [ProductModel] = []
    
    let productsService: ProductServiceProtocol
    
    init(productsService: ProductServiceProtocol) {
        self.productsService = productsService
    }
    
    func getProducts(onDownloadComplete: @escaping () -> Void) {
        Task {
            do {
                let result = try await productsService.getProducts()
                self.products = result
                self.filteredProducts = result
                onDownloadComplete()
            } catch {
                print(error)
            }
        }
    }
    
}
