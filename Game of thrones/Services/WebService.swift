//
//  WebService.swift
//  Game of thrones
//
//  Created by Kuda Zata on 18/9/2022.
//

import Foundation

/// The different error types that might occur when making network calls
enum NetworkError: Error {
    case badUrl
    case decodingError
    case badRequest
    case noData
    case custom(Error)
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        return "There was an error connecting to our server. Please try again"
    }
}

/// A resource object to be created when making network calls
struct Resource<T> {
    let urlString: String
    let parse: (Data) -> T?
}


/// The class responsible for all network calls within the app
final class WebService {
    
    /// Generic network caller that can take in and return any type of object
    /// - Parameters:
    ///    - resource: object of type Resource to be used for the network call
    ///    - completion: Code to be executed by the caller. Will contain type Result
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T?, NetworkError>) -> Void) {
        
        guard let url = URL(string: resource.urlString) else {
            completion(.failure(.badUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(.custom(error)))
                return
            }
            
            if (response as? HTTPURLResponse)?.statusCode != 200 {
                completion(.failure(.badRequest))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            completion(.success(resource.parse(data)))
            
        }.resume()
    }
    
    
    /// Fetch an array of houses
    /// - Parameters:
    ///   - pageNumber: page number for pagination purposes
    ///   - completion: Block of code to be executed by caller
    func getHouses(pageNumber: Int, completion: @escaping ([House]?, NetworkError?) -> Void) {

        let resource = Resource<[House]>(urlString: Urls.getHousesURL(pageNumber: pageNumber)) { data in
            let houses = try? JSONDecoder().decode([House].self, from: data)
            return houses
        }

        load(resource: resource) { result in
            switch result {
            case let .success(houses):
                completion(houses, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }
    
    /// Fetch a particular character
    /// - Parameters:
    ///   - url: url for the Character resource
    ///   - completion: Callback with either Character resource or a Network Error
    func getCharacter(url: String, completion: @escaping (Character?, NetworkError?) -> Void) {
        
        let resource = Resource<Character>(urlString: url) { data in
            let character = try? JSONDecoder().decode(Character.self, from: data)
            return character
        }

        load(resource: resource) { result in
            switch result {
            case let .success(character):
                completion(character, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }
    
    /// Fetch a particular House
    /// - Parameters:
    ///   - url: url for the House resource
    ///   - completion: callback containing either a House or a Network Error
    func getHouse(url: String, completion: @escaping (House?, NetworkError?) -> Void) {
        
        let resource = Resource<House>(urlString: url) { data in
            let house = try? JSONDecoder().decode(House.self, from: data)
            return house
        }

        load(resource: resource) { result in
            switch result {
            case let .success(house):
                completion(house, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }
    
}
