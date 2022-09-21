//
//  HouseTableViewCell.swift
//  Game of thrones
//
//  Created by Kuda Zata on 16/9/2022.
//

import UIKit

class HouseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!

    func configureCell(houseViewModel: HouseViewModel) {
        nameLabel.text = houseViewModel.name
        regionLabel.text = houseViewModel.region
    }

}
