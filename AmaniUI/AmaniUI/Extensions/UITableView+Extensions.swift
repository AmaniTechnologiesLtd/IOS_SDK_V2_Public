//
//  UITableView+Extensions.swift
//  Amani
//
//  Created by Münir Ketizmen on 5.08.2021.
//

import UIKit

extension UITableView {
    func reloadData(completion: @escaping () -> ()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData()})
        {_ in completion() }
    }
}
