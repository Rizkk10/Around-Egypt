//
//  SearchExtension.swift
//  Around Egypt
//
//  Created by Rezk on 16/04/2023.
//

import Foundation
import UIKit
extension HomeViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search experiences"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    func configureBookmarkButton() {
        bookmarkButton = UIButton(type: .system)
        bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        bookmarkButton.addTarget(self, action: #selector(bookmarkButtonTapped), for: .touchUpInside)
        
    }

    @objc func bookmarkButtonTapped() {
        // Handle bookmark button tap here
    }

    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        if let searchText = searchBar.text, !searchText.isEmpty {
            let searchViewController = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
            searchViewController.name = searchText
            self.navigationController?.pushViewController(searchViewController, animated: true)
        }
        return true
    }

}
