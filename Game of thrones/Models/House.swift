//
//  House.swift
//  Game of thrones
//
//  Created by Kuda Zata on 16/9/2022.
//

import Foundation

struct House: Decodable {
    var url: String
    var name: String
    var region: String
    var coatOfArms: String
    var words: String
    var titles: [String]
    var seats: [String]
    var currentLord: String
    var heir: String
    var overlord: String
    var founded: String
    var founder: String
    var diedOut: String
    var ancestralWeapons: [String]
    var cadetBranches: [String]
    var swornMembers: [String]
}

