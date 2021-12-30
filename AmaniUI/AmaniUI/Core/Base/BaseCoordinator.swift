//
//  BaseCoordinator.swift
//  Amani
//
//  Created by Münir Ketizmen on 5.08.2021.
//

import Foundation
import UIKit

class Coordinator {
    private(set) var childCorrdinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController!
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        preconditionFailure("Bu metodu override etmelisin.")
    }
    
    func addChildCoordinator(_ coordinator: Coordinator) {
//        let t = type(of: coordinator)
        childCorrdinators.removeAll{ type(of: $0) == type(of: coordinator) }
        childCorrdinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator) {
        if let index = childCorrdinators.lastIndex(where: { (coord) -> Bool in
            coordinator == coord
        }) {
            childCorrdinators.remove(at: index)
        }else {
            print("Child coordinator silinemedi. \(coordinator)")
        }
    }
    
    func removeAllChildCoordinators() {
        childCorrdinators.removeAll()
    }
    
    func removeOtherChildCorrdinators<T: Coordinator>(then: T.Type) {
        childCorrdinators.filter { (coord) -> Bool in
            return !(coord is T)
        }.forEach { (coord) in
            removeChildCoordinator(coord)
        }
    }
    
    func getCoordinator<T: Coordinator>(_ coor: T.Type) -> T {
        var coordinator = childCorrdinators.filter{ $0 is T }.last as? T
        if coordinator == nil {
            coordinator = T(navigationController)
            addChildCoordinator(coordinator!)
        }
        return coordinator!
    }
}


extension Coordinator {
    static func  == (lhs: Coordinator, rhs: Coordinator) -> Bool {
        return lhs === rhs
    }
}
