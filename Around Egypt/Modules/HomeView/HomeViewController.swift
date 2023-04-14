//
//  ViewController.swift
//  Around Egypt
//
//  Created by Rezk on 14/04/2023.
//

import UIKit
protocol HomeViewProtocol : AnyObject {
    
    func renderCollection()
}


class HomeViewController: UIViewController , HomeViewProtocol {
    
    @IBOutlet weak var recommendedExperience: UICollectionView!
    @IBOutlet weak var mostRecent: UICollectionView!
    var searchController: UISearchController!
    var viewModel : HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel()
        viewModel.bindResultToHomeView = {[weak self] in
            DispatchQueue.main.async{
                self?.renderCollection()
            }
        }
        viewModel.getRecommendedExperiences()
        viewModel.getRecentExperiences()
        configureSearchController()
    }
    
    
    func renderCollection() {
        self.recommendedExperience.reloadData()
        self.mostRecent.reloadData()
    }
}
extension HomeViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
       
    }
    
    func configureSearchController(){
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search experiences"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.delegate = self
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let searchViewController = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        self.navigationController?.pushViewController(searchViewController, animated: true)
        return true
    }
}


extension HomeViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == recommendedExperience {
            return viewModel.recommendedResult.count
        }
        return viewModel.recentResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == recommendedExperience {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendedExperiences", for: indexPath) as! RecommendedExperiencesCell
            cell.configCell(experience: viewModel.recommendedResult[indexPath.row])
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MostRecent", for: indexPath) as! MostRecentCell
        cell.configCell(experience: viewModel.recentResult[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == recommendedExperience {
            return CGSize(width: 169 , height: 169)
        }
        return CGSize(width: 169 , height: 169)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
}
