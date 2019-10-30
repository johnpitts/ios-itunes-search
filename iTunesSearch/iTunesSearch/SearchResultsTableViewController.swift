//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by John Pitts on 5/14/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var searchBar: UISearchBar!
    
    let searchResultsController = SearchResultController()
    
    var resultType: ResultType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = AppearanceHelper.backgroundBlue
        
        searchBar.delegate = self
    }
    
    @IBAction func segmentedControlSelected(_ sender: Any) {
        searchBarSearchButtonClicked(searchBar)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchBar.text else { return }
        
        switch segmentedControl.selectedSegmentIndex {
        
            case 0: resultType = .software
            case 1: resultType = .musicTrack
            case 2: resultType = .movie
            default: return
        }
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) { (_) in
            
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return searchResultsController.searchResults.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)
     
        let searchResult = searchResultsController.searchResults[indexPath.row]
     
        // elected not to create a seperate "style" function here, but easily could have
        cell.textLabel?.text = searchResult.title
        cell.textLabel?.textColor = AppearanceHelper.floridaOrange
        cell.textLabel?.font = AppearanceHelper.customFont(with: .body, pointSize: 30)
        cell.detailTextLabel?.text = searchResult.creator
        cell.detailTextLabel?.textColor = AppearanceHelper.floridaOrange
        cell.detailTextLabel?.font = AppearanceHelper.customFont(with: .footnote, pointSize: 20)
        cell.backgroundColor = AppearanceHelper.backgroundBlue
        


        return cell
    }

    
}
