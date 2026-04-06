//
//  ViewController.swift
//  Fake_Ecommerce_UIKit
//
//  Created by Mahmoud Nagdy on 04/04/2026.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editBtn: UIBarButtonItem!
    
    let vm = ProductsViewModel(productsService: ProductsService())
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.getProducts {
            if self.vm.filteredProducts.isEmpty {
                self.tableView.isHidden = true
            } else {
                self.tableView.isHidden = false
            }
            self.tableView.reloadData()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        txtSearch.delegate = self
        
        refreshControl.tintColor = .darkGray
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        tableView.refreshControl = refreshControl
        
        editBtn.target = self
        editBtn.action = #selector(editBtnAction)
    }
    
    
    @objc func editBtnAction() {
        tableView.isEditing.toggle()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.filteredProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductTableViewCell
        cell.setupCell(product: vm.filteredProducts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "") { action, view, completion in
            let itemToDelete = self.vm.filteredProducts[indexPath.row]
            self.vm.products.removeAll { $0.id == itemToDelete.id }
            self.vm.filteredProducts.remove(at: indexPath.row)
            tableView.reloadData()
            completion(true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        vm.filteredProducts.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ProductVC = storyboard?.instantiateViewController(withIdentifier: "productUI") as! ProductViewController
        ProductVC.product = vm.filteredProducts[indexPath.row]
        navigationController?.pushViewController(ProductVC, animated: true)
    }
    
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            vm.filteredProducts = vm.products.filter { $0.title.lowercased().contains(text.lowercased()) }
        } else {
            vm.filteredProducts = vm.products
        }
        
        if vm.filteredProducts.isEmpty {
            tableView.isHidden = true
        } else {
            tableView.isHidden = false
        }
        
        tableView.reloadData()
    }

    @objc func refresh() {
        refreshControl.beginRefreshing()
        vm.getProducts {
            self.tableView.reloadData()
        }
        refreshControl.endRefreshing()
        txtSearch.text = ""
    }
    
    

}

