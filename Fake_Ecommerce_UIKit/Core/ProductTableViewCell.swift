//
//  ProductTableViewCell.swift
//  Fake_Ecommerce_UIKit
//
//  Created by Mahmoud Nagdy on 04/04/2026.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var brandLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var stockLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupCell(product: ProductModel) {
        titleLbl.text = product.title
        descLbl.text = product.description
        brandLbl.text = product.brand
        priceLbl.text = "$\(product.price)"
        stockLbl.text = "\(product.stock)"
        ratingLbl.text = "\(product.rating)"
        
        getImage(imageUrl: product.images.first ?? "")
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
