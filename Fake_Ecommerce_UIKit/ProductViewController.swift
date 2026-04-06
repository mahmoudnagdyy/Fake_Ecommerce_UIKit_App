//
//  ProductViewController.swift
//  Fake_Ecommerce_UIKit
//
//  Created by Mahmoud Nagdy on 06/04/2026.
//

import UIKit

class ProductViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionVeiw: UICollectionView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var lblProductBrand: UILabel!
    @IBOutlet weak var lblProductDescription: UILabel!
    var product: ProductModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = product?.title
        lblProductName.text = product?.title
        lblProductPrice.text = "$ " + (product?.price.description ?? "0")
        if let brand = product?.brand {
            lblProductBrand.text = brand
        } else {
            lblProductBrand.isHidden = true
        }
        lblProductDescription.text = product?.description
        
        collectionVeiw.delegate = self
        collectionVeiw.dataSource = self
        
        pageControl.numberOfPages = product?.images.count ?? 0
        pageControl.currentPage = 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product?.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colProductCell", for: indexPath) as! ProductCollectionViewCell
        cell.setupCell(image: product?.images[indexPath.row] ?? "no image")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }

}
