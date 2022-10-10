//
//  WebServiceMock.swift
//  Game of thronesTests
//
//  Created by Kuda Zata on 10/10/2022.
//

import Foundation
@testable import Game_of_thrones

struct WebServiceMock: WebServiceProtocol {
    
    var shouldReturnError: Bool
    
    func getHouses(pageNumber: Int, completion: @escaping ([House]?, NetworkError?) -> Void) {
        if shouldReturnError {
            completion(nil, .badRequest)
        }
        else {
            let house1 = House(url: "",
                               name: "Test House 1",
                               region: "The North",
                               coatOfArms: "A silver sword",
                               words: "No words",
                               titles: ["Lord", "King"],
                               seats: ["Godsgrace", ""],
                               currentLord: "Lord Bayley",
                               heir: "Lord Jeffery",
                               overlord: "House of commons",
                               founded: "1900",
                               founder: "Lord disick",
                               diedOut: "1920",
                               ancestralWeapons: ["Knife", "Gun"],
                               cadetBranches: ["", ""],
                               swornMembers: ["Ariana", "Caroline"])
            
            let house2 = House(url: "",
                               name: "Test House 2",
                               region: "Test region",
                               coatOfArms: "A golden wreath",
                               words: "No words",
                               titles: ["Lord", "King"],
                               seats: ["Godsgrace", ""],
                               currentLord: "Lord Bayley",
                               heir: "Lord Jeffery",
                               overlord: "House of commons",
                               founded: "1900",
                               founder: "Lord disick",
                               diedOut: "1920",
                               ancestralWeapons: ["Knife", "Gun"],
                               cadetBranches: ["", ""],
                               swornMembers: ["Ariana", "Caroline"])
            
            completion([house1, house2], nil)
        }
    }
    
    func getCharacter(url: String, completion: @escaping (Character?, NetworkError?) -> Void) {
        if shouldReturnError {
            completion(nil, .badRequest)
        }
        else {
            let character = Character(name: "Lord Bayley", gender: "Male", aliases: [""])
            completion(character, nil)
        }
    }
    
    func getHouse(url: String, completion: @escaping (House?, NetworkError?) -> Void) {
        
        if shouldReturnError {
            completion(nil, .badRequest)
        }
        else {
            let house = House(url: "",
                               name: "Test House 1",
                               region: "The North",
                               coatOfArms: "A silver sword",
                               words: "No words",
                               titles: ["Lord", "King"],
                               seats: ["Godsgrace", ""],
                               currentLord: "Lord Bayley",
                               heir: "Lord Jeffery",
                               overlord: "House of commons",
                               founded: "1900",
                               founder: "Lord disick",
                               diedOut: "1920",
                               ancestralWeapons: ["Knife", "Gun"],
                               cadetBranches: ["", ""],
                               swornMembers: ["Ariana", "Caroline"])
            
            completion(house, nil)
        }
    }
    
}
