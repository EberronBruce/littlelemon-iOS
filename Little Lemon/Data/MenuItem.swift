//
//  Menu.swift
//  Little Lemon
//
//  Created by Bruce Burgess on 10/24/23.
//

import Foundation

struct MenuList: Decodable {
    let menu: [MenuItem]
}

struct MenuItem: Decodable {
    let title: String
    let image: String
    let price: String
    let description: String
    let category: String
}
