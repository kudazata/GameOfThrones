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
    func errorFetchingHouseDetails(error: NetworkError)
}

class HouseDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, HouseDetailsControllerDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var pageTitle = ""
    var house: House!
    var houseDetailsVM = HouseDetailsViewModel()
    var webService: WebServiceProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.title = pageTitle
        houseDetailsVM.house = house
        houseDetailsVM.delegate = self
        houseDetailsVM.webService = webService
        houseDetailsVM.getHouseDetails()
    }

    //MARK: - Delegate functions
    
    ///Function called from HouseDetailsViewModel when fetching house details is finished
    func didFinishFetchingHouseDetails() {
        DispatchQueue.main.async {
            print(self.houseDetailsVM.numberOfRowsInSection(0))
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    ///Function called from HouseDetailsViewModel when there's been an error fetching houses
    func errorFetchingHouseDetails(error: NetworkError) {
        DispatchQueue.main.async {
            
            var errorMessage = ""
            self.activityIndicator.stopAnimating()
            
            switch error {
            case .customError(let customError):
                errorMessage = customError.localizedDescription
                
            default:
                errorMessage = error.localizedDescription
            }
            
            showRetryAlert(title: "Network error", message: errorMessage, vc: self) {
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
