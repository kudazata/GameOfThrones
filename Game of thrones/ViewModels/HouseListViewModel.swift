//
//  HouseListViewModel.swift
//  Game of thrones
//
//  Created by Kuda Zata on 16/9/2022.
//

import Foundation

/// ViewModel for the HouseListViewController
class HouseListViewModel {
    
    var delegate: HouseListControllerDelegate?
    
    /// Array of ALL houses fetched from backend
    var houses = [House]()
    
    /// An array of houses populated when NEW houses are fetched from the backend using pagination
    var newHouses = [House]()
    
    
    /// Will be true when all houses have been fetched from the backend
    var allDataFetched = false
    
    /// Number of sections in the TableView in HouseListViewController.
    /// First section is for the Houses and the second section is for the Loading cell shown when fetching new houses using pagination
    var numberOfSections: Int {
        return 2
    }
    
    /// Number of rows in the TableView in HouseListViewController
    /// First section will be equal to the number of houses fetched
    /// Second section is for loading cell. It will be 1 if fetching more houses. Will be 0 if all houses have been fetched
    /// - Parameter section: section index
    /// - Returns: number of rows for given section
    func numberOfRowsInSection(_ section: Int) -> Int {
        if section == 0 {
            return houses.count
        }
        else {
            return allDataFetched ? 0 : 1
        }
    }
    

    /// Returns HouseViewModel used to populate HouseTableViewCell
    func houseAtIndex(_ index: Int) -> HouseViewModel {
        let house = self.houses[index]
        return HouseViewModel(house)
    }
    
    /// Network call for fetching Houses from backend.
    /// - Parameter pageNumber: page number for pagination
    func fetchHouses(pageNumber: Int)  {
        WebService().getHouses(pageNumber: pageNumber) { houses, error in
            
            if let error = error {
                self.delegate?.errorFetchingHouses(error: error)
                return
            }
            
            if let houses = houses {
                self.houses.append(contentsOf: houses)
                self.newHouses = houses
                self.allDataFetched = self.newHouses.count == 0
                self.delegate?.didFetchHouses()
            }
            else {
                print("no houses")
            }
        }
    }
    
}

