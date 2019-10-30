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
    
    var creator: String?
    var title: String?

    //   if you want to return MOVIES I believe another property will need to be added here
}

struct SearchResults: Codable {
    
    var results: [SearchResult] = []
    
}
