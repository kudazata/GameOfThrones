//
//  HouseViewModel.swift
//  Game of thrones
//
//  Created by Kuda Zata on 20/9/2022.
//

import Foundation

/// ViewModel for HouseTableViewCell
struct HouseViewModel {
    
    init(_ house: House) {
        self.house = house
    }
    
    private let house: House
    
    var name: String {
        return house.name
    }
    
    var region: String {
        return house.region
    }
}
