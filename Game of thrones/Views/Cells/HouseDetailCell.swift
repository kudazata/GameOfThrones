//
//  HouseDetailCell.swift
//  Game of thrones
//
//  Created by Kuda Zata on 16/9/2022.
//

import UIKit

class HouseDetailCell: UITableViewCell {

    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailInformation: UILabel!
    
    func configureCell(houseDetailItemVM: HouseDetailItemViewModel) {
        detailTitle.text = houseDetailItemVM.title
        detailInformation.text = houseDetailItemVM.value
    }
}
