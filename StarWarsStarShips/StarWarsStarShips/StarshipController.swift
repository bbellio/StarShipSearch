//
//  StarshipController.swift
//  StarWarsStarShips
//
//  Created by Bethany Wride on 10/3/19.
//  Copyright © 2019 Bethany Wride. All rights reserved.
//

import Foundation

class StarshipController {
    static let baseURL = URL(string: StarshipConstants.baseURL)
    
    static func fetchStarshipsWith(searchText: String, completion: @escaping ([Starship]) -> Void) {
        guard let unwrappedURL = baseURL else {
            completion([])
            return
        }
        // Converting URL into URLComponents that can then be appended (rather than being a string), and resolvingAgainstBaseURL just says it's going to append to the base URL rather than anything else
        guard var urlComponents = URLComponents(url: unwrappedURL, resolvingAgainstBaseURL: true) else {
            completion([])
            return
        }
        let searchTermQuery = URLQueryItem(name: StarshipConstants.searchKey, value: searchText)
        // Can also guard let this bad boy
        urlComponents.queryItems = [searchTermQuery]
        guard let finalURL = urlComponents.url else {
            print("Error with URL components")
            completion([])
            return
        }
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion([])
                return
            }
            
            guard let unwrappedData = data else {
                print("No data")
                completion([])
                return
            }
            
            do {
                let decodedStarships = try JSONDecoder().decode(SearchResults.self, from: unwrappedData)
                completion(decodedStarships.results)
            } catch {
                print("Error decoding data")
            }
        }.resume() // End of dataTask
    } // End of function
    
    // make film optional?
    static func getFilm(filmURL: String, completion: @escaping (Film?) -> Void) {
        guard let url = URL(string: filmURL) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(nil)
                return
            }
            
            guard let unwrappedData = data else {
                print("No data")
                completion(nil)
                return
            }
            
            do {
                let decodedFilms = try JSONDecoder().decode(Film.self, from: unwrappedData)
                completion(decodedFilms)
            } catch {
                print("Error decoding film")
            }
        }.resume() // End of dataTask
    } // End of function
} // End of class
