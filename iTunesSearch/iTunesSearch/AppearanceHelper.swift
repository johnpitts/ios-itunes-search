//
//  AppearanceHelper.swift
//  iTunesSearch
//
//  Created by John Pitts on 5/28/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import Foundation
import UIKit

enum AppearanceHelper {
    
    static var floridaOrange = UIColor(red: 216.0/255.0, green: 137.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    static var backgroundBlue = UIColor(red: 8.0/255.0, green: 0.0/255.0, blue: 254.0/255.0, alpha: 1.0)
    
    static func setColorAppearance() {
        UISegmentedControl.appearance().tintColor = floridaOrange
        UINavigationBar.appearance().backgroundColor = backgroundBlue
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: floridaOrange]
        UINavigationBar.appearance().titleTextAttributes = textAttributes
        UISearchBar.appearance().barTintColor = floridaOrange
        UIView.appearance().backgroundColor = backgroundBlue
        
    }
}
