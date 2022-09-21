//
//  HouseDetailItemViewModel.swift
//  Game of thrones
//
//  Created by Kuda Zata on 20/9/2022.
//

import Foundation

/// ViewModel for HouseDetailCell
struct HouseDetailItemViewModel {
    private let houseDetailItem: HouseDetailItem
    
    init(_ houseDetailItem: HouseDetailItem) {
        self.houseDetailItem = houseDetailItem
    }
    
    var title: String {
        return houseDetailItem.title.titlecased()
    }
    
    var value: String {
        return houseDetailItem.value
    }
}
