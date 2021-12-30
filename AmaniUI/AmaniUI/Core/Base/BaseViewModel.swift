//
//  BaseViewModel.swift
//  Amani
//
//  Created by Münir Ketizmen on 5.08.2021.
//

import Foundation

protocol ViewModelLoadableProtocol : class {
    func load()
}

public class BaseViewModel: ViewModelLoadableProtocol {
    required init() {}
    
    func load() {
        preconditionFailure("Bu metodu override etmelisin.")
    }
}


