//
//  CoreDataConstant.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 27.01.2021.
//

import Foundation

protocol CoreDataConstantProtocol {
    var name: String { get }
}

struct CoreDataConstant: CoreDataConstantProtocol {
    let name = "DataBase"
}
