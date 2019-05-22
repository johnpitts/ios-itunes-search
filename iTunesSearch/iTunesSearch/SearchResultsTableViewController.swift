//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by John Pitts on 5/14/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    
    @IBAction func segmentedControlSelected(_ sender: Any) {
        
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
     
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator
        


        return cell
    }

    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var searchBar: UISearchBar!
    
    let searchResultsController = SearchResultController()
    
    var resultType: ResultType!
    
}
