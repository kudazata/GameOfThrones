//
//  HouseDetailsViewController.swift
//  Game of thrones
//
//  Created by Kuda Zata on 16/9/2022.
//

import UIKit

///Protocol used to communicate betwen HouseDetailsViewController and HouseDetailsViewModel
protocol HouseDetailsControllerDelegate {
    func didFinishFetchingHouseDetails()
    func errorFetchingHouseDetails(error: Error)
}

class HouseDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, HouseDetailsControllerDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var pageTitle = ""
    var house: House!
    var houseDetailsVM = HouseDetailsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.title = pageTitle
        houseDetailsVM.house = house
        houseDetailsVM.delegate = self
        houseDetailsVM.getHouseDetails()
    }

    //MARK: - Delegate functions
    
    ///Function called from HouseDetailsViewModel when fetching house details is finished
    func didFinishFetchingHouseDetails() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    ///Function called from HouseDetailsViewModel when there's been an error fetching houses
    func errorFetchingHouseDetails(error: Error) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            showRetryAlert(title: "Network error", message: error.localizedDescription, vc: self) {
                self.activityIndicator.startAnimating()
                self.houseDetailsVM.getHouseDetails()
            }
        }
    }
    
    
    
    // MARK: - TableView functions

    func numberOfSections(in tableView: UITableView) -> Int {
        return houseDetailsVM.numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return houseDetailsVM.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! HouseDetailCell
        let houseDetailItemVM = houseDetailsVM.houseDetailItemForIndex(indexPath.row)
        cell.configureCell(houseDetailItemVM: houseDetailItemVM)
        return cell
    }
    
}
