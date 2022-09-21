//
//  Constants.swift
//  Game of thrones
//
//  Created by Kuda Zata on 18/9/2022.
//

import Foundation

struct Urls {
    
    /// This function generates and return a url string for pagination purpopes
    /// - Parameter pageNumber: pagination page number
    /// - Returns: url string
    static func getHousesURL(pageNumber: Int) -> String {
        return "https://anapioficeandfire.com/api/houses?page=\(pageNumber)&pageSize=10"
    }
    
}
