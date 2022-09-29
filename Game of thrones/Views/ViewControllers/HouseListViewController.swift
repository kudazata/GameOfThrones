//
//  HouseListViewController.swift
//  Game of thrones
//
//  Created by Kuda Zata on 16/9/2022.
//

import UIKit

///Protocol used to communicate betwen HouseListViewController and HouseListViewModel
protocol HouseListControllerDelegate {
    func didFetchHouses()
    func errorFetchingHouses(error: NetworkError)
}

class HouseListViewController: UITableViewController, HouseListControllerDelegate {
    
    var houseListViewModel = HouseListViewModel()
    private var pageNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        houseListViewModel.delegate = self
        houseListViewModel.fetchHouses(pageNumber: pageNumber)
    }
    
    //MARK: - Delegate functions
    
    
    /// Delegate method called from HouseListViewModel when fetching houses from backend is done
    /// Used to update tableview with new data and increment pageNumber property
    func didFetchHouses() {
        DispatchQueue.main.async {
            if self.pageNumber ==  1 {
                self.tableView.reloadData()
            }
            else {
                if self.houseListViewModel.newHouses.count > 0 {
                    let cellsToUpdate = self.cellsToUpdate()
                    self.tableView.beginUpdates()
                    self.tableView.insertRows(at: cellsToUpdate, with: .fade)
                    self.tableView.endUpdates()
                }
                else {
                    self.tableView.deleteRows(at: [IndexPath(row: 0, section: 1)], with: .automatic)
                }
            }
            self.pageNumber += 1
        }
    }
    
    /// Delegate method called from HouseListViewModel when an error has occured whilst fetching houses from backend
    func errorFetchingHouses(error: NetworkError) {
        DispatchQueue.main.async {
            
            var errorMessage = ""
            switch error {
                
            case .customError(let customError):
                errorMessage = customError.localizedDescription
            default:
                errorMessage = error.localizedDescription
            }

            showRetryAlert(title: "Network error", message: errorMessage, vc: self) {
                self.houseListViewModel.fetchHouses(pageNumber: self.pageNumber)
            }
        }
    }

    // MARK: - TableView functions

    override func numberOfSections(in tableView: UITableView) -> Int {
        return houseListViewModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return houseListViewModel.numberOfRowsInSection(section)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "houseCell", for: indexPath) as! HouseTableViewCell
            let houseViewModel = houseListViewModel.houseAtIndex(indexPath.row)
            cell.configureCell(houseViewModel: houseViewModel)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "loadingCell", for: indexPath)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let houseDetailsVC = UIStoryboard(name: "HouseDetails", bundle: nil).instantiateViewController(withIdentifier: "houseDetailsVC") as! HouseDetailsViewController
        houseDetailsVC.pageTitle = houseListViewModel.houseAtIndex(indexPath.row).name
        houseDetailsVC.house = houseListViewModel.houses[indexPath.row]
        self.navigationController?.pushViewController(houseDetailsVC, animated: true)
    }
    
    
    /// This tableView function tells us when we have reached the last cell
    /// At this point we will fetch more data from backend using pagination, provided that 'allDataFetched' is false
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == houseListViewModel.houses.count - 1 {
            if !houseListViewModel.allDataFetched {
                houseListViewModel.fetchHouses(pageNumber: pageNumber)
            }
        }
    }
    
    
    /// Used to determine which cells need to be updated when new data has been fetched
    /// - Returns: An array of IndexPath objects
    private func cellsToUpdate() -> [IndexPath] {
        let startIndex = houseListViewModel.houses.count - houseListViewModel.newHouses.count
        let endIndex = startIndex + houseListViewModel.newHouses.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }

}
