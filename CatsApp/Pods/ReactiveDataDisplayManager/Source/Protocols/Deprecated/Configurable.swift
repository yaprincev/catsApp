//
//  ConfigurableProtocol.swift
//  ReactiveDataDisplayManager
//
//  Created by Mikhail Monakov on 17/01/2019.
//  Copyright © 2019 Александр Кравченков. All rights reserved.
//

import UIKit

/// Protocol for UIView (basically for UICollectionViewCell&UITableViewCell) which is supposed to be used in CellGenerators
@available(*, deprecated, renamed: "ConfigurableItem")
public protocol Configurable where Self: UIView {

    associatedtype Model

    func configure(with model: Model)
    
}
