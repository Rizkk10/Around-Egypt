//
//  ViewController.swift
//  Around Egypt
//
//  Created by Rezk on 14/04/2023.
//

import UIKit
import SwiftUI
import Reachability

protocol HomeViewProtocol : AnyObject {
    
    func renderCollection()
}


class HomeViewController: UIViewController , HomeViewProtocol {
    
    @IBOutlet weak var recommendedExperience: UICollectionView!
    @IBOutlet weak var mostRecent: UICollectionView!
    var searchController: UISearchController!
    var viewModel : HomeViewModel!
    let reachability = try! Reachability()
    let cache = NSCache<NSString, NSArray>()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel()
        viewModel.bindResultToHomeView = {[weak self] in
            DispatchQueue.main.async{
                self?.renderCollection()
            }
        }
        
        if reachability.connection != .unavailable {
            viewModel.getRecommendedExperiences()
            viewModel.getRecentExperiences()
        } else {
            // Load data from cache if app is offline
            if let cachedRecommended = cache.object(forKey: "recommendedExperiences") as? [Experiences] {
                viewModel.recommendedResult = cachedRecommended
            }
            
            if let cachedRecent = cache.object(forKey: "recentExperiences") as? [Experiences] {
                viewModel.recentResult = cachedRecent
            }
            renderCollection()
        }
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
            return CGSize(width: recommendedExperience.frame.width , height: recommendedExperience.frame.height)
        }
        return CGSize(width: mostRecent.frame.width , height: mostRecent.frame.height)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let Experience = ExperienceScreenData()
        if collectionView == recommendedExperience {
            Experience.experienceID = viewModel.recommendedResult[indexPath.row].id!
        }
        if collectionView == mostRecent {
            Experience.experienceID = viewModel.recentResult[indexPath.row].id!
        }
        let ExperienceVC = UIHostingController(rootView: ExperienceScreen().environmentObject(Experience))
        
        self.navigationController?.pushViewController(ExperienceVC, animated: true)
    }
    
    
}
