//
//  ProductServiceProtocol.swift
//  Fake_Ecommerce_UIKit
//
//  Created by Mahmoud Nagdy on 04/04/2026.
//

import Foundation



protocol ProductServiceProtocol {
    func getProducts() async throws -> [ProductModel]
}
