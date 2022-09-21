//
//  LoadingCell.swift
//  Game of thrones
//
//  Created by Kuda Zata on 20/9/2022.
//

import UIKit

///Used for infinite scrolling. Shown when fetching new data from backend
class LoadingCell: UITableViewCell {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
            if let activityIndicator = self.activityIndicator {
                activityIndicator.startAnimating()
            }
    }

}
