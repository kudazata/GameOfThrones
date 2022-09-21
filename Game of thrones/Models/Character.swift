//
//  Character.swift
//  Game of thrones
//
//  Created by Kuda Zata on 19/9/2022.
//

import Foundation

struct Character: Decodable {
    var name: String
    var gender: String
    var aliases: [String]
}
