//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by John Pitts on 5/14/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import UIKit

struct SearchResult: Codable {
    
    enum CodingKeys: String, CodingKey {
        
        case title = "trackName"
        case creator = "artistName"
    }
    
    var title: String
    var creator: String
}

struct SearchResults: Codable {
    
    var results: [SearchResult] = []
    
}
