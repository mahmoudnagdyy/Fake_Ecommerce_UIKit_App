//
//  ProductCollectionViewCell.swift
//  Fake_Ecommerce_UIKit
//
//  Created by Mahmoud Nagdy on 06/04/2026.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImg: UIImageView!

    func setupCell(image: String) {
        getImage(imageUrl: image)
    }
    
    private func getImage(imageUrl: String) {
        guard let url = URL(string: imageUrl) else { return }
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                self.productImg.image = UIImage(data: data)
            } catch {
                print(error)
            }
        }
    }
}
