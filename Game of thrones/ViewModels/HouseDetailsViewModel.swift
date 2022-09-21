//
//  HouseDetailsViewModel.swift
//  Game of thrones
//
//  Created by Kuda Zata on 16/9/2022.
//

import Foundation
import UIKit


/// ViewModel for HouseDetailsViewController
class HouseDetailsViewModel {
    
    /// An array of HouseDetailItem objects
    private var houseDetailItems = [HouseDetailItem]()
    
    var house: House?
    var delegate: HouseDetailsControllerDelegate?
    
    /// Property in House object. Will be fetched from backend if url provided
    var currentLord: Character?
    
    /// Property in House object. Will be fetched from backend if url provided
    var heir: Character?
    
    /// Property in House object. Will be fetched from backend if url provided
    var overlord: House?
    
    /// Property in House object. Will be fetched from backend if url provided
    var founder: Character?
    
    /// Property in House object. Will be fetched from backend if url provided
    var cadetBranches: [House]?
    
    /// Property in House object. Will be fetched from backend if url provided
    var swornMembers: [Character]?
    
    /// Dispatch group for the multiple network calls for fetching properties in House object
    private var dispatchGroup = DispatchGroup()
    
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return houseDetailItems.count
    }
    
    
    /// 
    /// - Parameter index: tableview indexpath.row
    /// - Returns: HouseDetailViewModel for populating HouseDetailCell
    func houseDetailItemForIndex(_ index: Int) -> HouseDetailItemViewModel {
        let houseDetailItem = houseDetailItems[index]
        return HouseDetailItemViewModel(houseDetailItem)
    }
    
    /// Fetch all properties for House object from backend. Loops through House object and fetches properties where URL is provided
    func getHouseDetails() {
        
        guard let house = house else {
            return
        }
        
        let mirror = Mirror(reflecting: house)
        
        for child in mirror.children {
            if let value = child.value as? String, let _ = URL(string: value) {
                let label = child.label
                switch label {
                case "currentLord":
                    getCurrentLord(urlString: value)
                case "heir":
                    getHeir(urlString: value)
                case "overlord":
                    getOverlord(urlString: value)
                case "founder":
                    getFounder(urlString: value)
                default:
                    print("do nothing")
                }
            }
            
            if let values = child.value as? [String], values.count > 0 {
                let label = child.label
                switch label {
                case "cadetBranches":
                    getCadetBranches(urlStrings: values)
                case "swornMembers":
                    getSwornMembers(urlStrings: values)
                default:
                    print("do nothing")
                }
            }
        }
        
        self.dispatchGroup.notify(queue: .main) {
            self.populateHouseDetails()
        }
    }
    
    /// Loops through House object and populates houseDetailItems array
    /// Skips properties with empty values
    /// Also adds special properties where URLs were provided by checking if they are not nil
    func populateHouseDetails() {
        
        guard let house = house else {
            return
        }
        
        let mirror = Mirror(reflecting: house)
        for child in mirror.children {
            if let value = child.value as? String, value != "" {
                if isUrl(string: value) {
                    continue
                } else {
                    let item = HouseDetailItem(title: child.label!, value: value)
                    self.houseDetailItems.append(item)
                }
            }
            else if let values = child.value as? [String], values.count > 0 {
                var valueString = ""
                for value in values {
                    if value != "" {
                        if isUrl(string: value) {
                            continue
                        }
                        else {
                            valueString = valueString + value + "\n"
                        }
                    }
                }
                if valueString != "" {
                    let item = HouseDetailItem(title: child.label!, value: valueString)
                    self.houseDetailItems.append(item)
                }
            }
        }
        
        if let currentLord = self.currentLord {
            let item = HouseDetailItem(title: "currentLord", value: currentLord.name)
            self.houseDetailItems.append(item)
        }
        
        if let heir = heir {
            let item = HouseDetailItem(title: "heir", value: heir.name)
            self.houseDetailItems.append(item)
        }
        
        if let overlord = overlord {
            let item = HouseDetailItem(title: "overlord", value: overlord.name)
            self.houseDetailItems.append(item)
        }
        
        if let founder = founder {
            let item = HouseDetailItem(title: "founder", value: founder.name)
            self.houseDetailItems.append(item)
        }
        
        if let cadetBranches = cadetBranches {
            var valueString = ""
            for branch in cadetBranches {
                valueString = valueString + branch.name + "\n"
            }
            let item = HouseDetailItem(title: "cadetBranches", value: valueString)
            self.houseDetailItems.append(item)
        }
        
        if let swornMembers = swornMembers {
            var valueString = ""
            for member in swornMembers {
                valueString = valueString + member.name + "\n"
            }
            let item = HouseDetailItem(title: "swornMembers", value: valueString)
            self.houseDetailItems.append(item)
        }
        
        self.delegate?.didFinishFetchingHouseDetails()
    }
    
    
    /// Fetch currentLord property and populate it
    /// - Parameter urlString: url for currentLord resource
    func getCurrentLord(urlString: String) {
        self.dispatchGroup.enter()
        WebService().getCharacter(url: urlString) { character, error in
            
            if let error = error {
                self.delegate?.errorFetchingHouseDetails(error: error)
                return
            }
            
            if let character = character {
                self.currentLord = character
            }
            self.dispatchGroup.leave()
        }
    }
    
    /// Fetch heir property and populate it
    /// - Parameter urlString: url for currentLord resource
    func getHeir(urlString: String) {
        
        self.dispatchGroup.enter()
        
        WebService().getCharacter(url: urlString) { character, error in
            
            if let error = error {
                self.delegate?.errorFetchingHouseDetails(error: error)
                return
            }
            
            if let character = character {
                self.heir = character
            }
            self.dispatchGroup.leave()
        }
    }
    
    
    /// Fetch overlord property and populate it
    /// - Parameter urlString: url for overlord resource
    func getOverlord(urlString: String) {
        
        self.dispatchGroup.enter()
        
        WebService().getHouse(url: urlString) { house, error in
            
            if let error = error {
                self.delegate?.errorFetchingHouseDetails(error: error)
                return
            }
            
            if let house = house {
                self.overlord = house
            }
            self.dispatchGroup.leave()
        }
    }
    
    
    /// Fetch founder property and populate it
    /// - Parameter urlString: url for founder resource
    func getFounder(urlString: String) {
        self.dispatchGroup.enter()
        
        WebService().getCharacter(url: urlString) { character, error in
            
            if let error = error {
                self.delegate?.errorFetchingHouseDetails(error: error)
                return
            }
            
            if let character = character {
                self.founder = character
            }
            self.dispatchGroup.leave()
        }
    }
    
    
    /// Fetch cadetBranches property and populate it
    /// - Parameter urlString: url for cadetBranches resource
    func getCadetBranches(urlStrings: [String]) {
        self.cadetBranches = [House]()
        
        for urlString in urlStrings {
            if let _ = URL(string: urlString) {
                self.dispatchGroup.enter()
                WebService().getHouse(url: urlString) { house, error in
                    
                    if let error = error {
                        self.delegate?.errorFetchingHouseDetails(error: error)
                        return
                    }
                    
                    if let house = house {
                        self.cadetBranches?.append(house)
                    }
                    self.dispatchGroup.leave()
                    
                }
            }
        }
    }
    
    
    /// Fetch swornMembers property and populate it
    /// - Parameter urlString: url for swornMembers resource
    func getSwornMembers(urlStrings: [String]) {
        self.swornMembers = [Character]()
        
        for urlString in urlStrings {
            if let _ = URL(string: urlString) {
                self.dispatchGroup.enter()
                WebService().getCharacter(url: urlString) { character, error in
                    
                    if let error = error {
                        self.delegate?.errorFetchingHouseDetails(error: error)
                        return
                    }
                    
                    if let character = character {
                        self.swornMembers?.append(character)
                    }
                    self.dispatchGroup.leave()
                }
            }
        }
    }
    
    
    /// Used to check if property value is a URL or a normal string
    /// - Parameter string: property value
    /// - Returns: true or false
    private func isUrl(string: String?) -> Bool {
       
        guard let urlString = string, let url = URL(string: urlString) else {
            return false
        }

        if !UIApplication.shared.canOpenURL(url) {
            return false
        }

        let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[regEx])
        return predicate.evaluate(with: string)
        
    }

}




