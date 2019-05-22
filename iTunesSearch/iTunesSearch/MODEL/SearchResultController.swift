//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by John Pitts on 5/14/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import Foundation

class SearchResultController {
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        
        let searchURL = baseURL.appendingPathComponent("search") // i mightg need to put '?' after search

        // i don't know why this is even here, doesn't URL(string: "https....") take care of this??
        // Do I need urlComponents if all i'm using is the baseURL?
        var urlComponents = URLComponents(url: searchURL, resolvingAgainstBaseURL: true)
        
        let searchQueryItem2 = URLQueryItem(name: "entity", value: resultType.rawValue)
        let searchQueryItem = URLQueryItem(name: "term", value: searchTerm)
        
        // property of URLComponents '.queryItems' is always an array of query items in order which they appear
        urlComponents?.queryItems = [searchQueryItem, searchQueryItem2]
        
        // We ask the urlComponents for a fully formatted url using the peopleURL that we gave it in the initializer and adding the query parameters onto it
        guard let formattedURL = urlComponents?.url else {
            //completion(error)   error doesn't work here, so do i need a completion if urlComponents?.url comes up nil?
            return
        }
        
        var request = URLRequest(url: formattedURL)
        
        request.httpMethod = HTTPMethod.get.rawValue
        
        // Perform the request (go to the API)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
        
        // Are there any errors from the API?
        if let error = error {
            NSLog("Error searching for people: \(error)")
            completion(error)
            return
        }
        
        // Make sure that we got (JSON) data back
        
        guard let data = data else {
            NSLog("No data returned from data task")
            completion(error)
            return
        }
        
        do {
        
            let decoder = JSONDecoder()
        
            let searchResults = try decoder.decode(SearchResults.self, from: data)
        
            self.searchResults = searchResults.results   // data goes into our model
        
            // We've put the new people in the array, should we reload the table view with DispatchQueue.main?
            completion(nil)    // is this right?
        
        } catch      // i don't understand this notation at all.  let decodingError??
            let decodingError {
            NSLog("Error decoding SearchResult from data: \(decodingError)")
            completion(decodingError)  // is this right?
        }
        }
        dataTask.resume()
    }
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    let baseURL = URL(string: "https://itunes.apple.com")!
    
    var searchResults: [SearchResult] = []
}
