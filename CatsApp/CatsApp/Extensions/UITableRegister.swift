//
//  UITableRegister.swift
//  CatsApp
//
//  Created by Максим Япринцев on 23.04.2024.
//

import Foundation
import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(cell: T.Type) {
        self.register(UINib(nibName: "\(cell.self)", bundle: nil), forCellReuseIdentifier: "\(cell.self)")
    }
    
}

