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
    var bookmarkButton: UIButton!
    var viewModel : HomeViewModel!
    let reachability = try! Reachability()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel()
        viewModel.bindResultToHomeView = {[weak self] in
            DispatchQueue.main.async{
                self?.renderCollection()
            }
        }
        checkConnection()
        configureSearchController()
    }
    
    
    @IBAction func recommendedLikeTapped(_ sender: Any) {
        let buttonPosition = (sender as AnyObject).convert(CGPoint.zero, to: self.recommendedExperience)
        if let indexPath = self.recommendedExperience.indexPathForItem(at: buttonPosition) {
            let experience = viewModel.recommendedResult[indexPath.row]
            
            if !(experience.isLiked ?? false) {
                
                experience.likes_no! += 1
                experience.isLiked = true
                
                viewModel.recommendedResult[indexPath.row] = experience
                self.recommendedExperience.reloadItems(at: [indexPath])
                
                guard let url = URL(string: "http://aroundegypt.34ml.com/api/v2/experiences/\(String(describing: experience.id))/like") else { return }
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                let task = URLSession.shared.dataTask(with: request) { [self] (data, response, error) in
                    guard response is HTTPURLResponse else {
                        DispatchQueue.main.async { [self] in
                            recommendedExperience.reloadData()
                        }
                        return
                    }
                }
                task.resume()
            }
        }
    }
    
    @IBAction func recentLikeTapped(_ sender: Any) {
        let buttonPosition = (sender as AnyObject).convert(CGPoint.zero, to: self.mostRecent)
        if let indexPath = self.mostRecent.indexPathForItem(at: buttonPosition) {
            let experience = viewModel.recentResult[indexPath.row]
            
            if !(experience.isLiked ?? false) {
                
                experience.likes_no! += 1
                experience.isLiked = true
                
                viewModel.recentResult[indexPath.row] = experience
                self.mostRecent.reloadItems(at: [indexPath])
                
                guard let url = URL(string: "http://aroundegypt.34ml.com/api/v2/experiences/\(String(describing: experience.id))/like") else { return }
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                let task = URLSession.shared.dataTask(with: request) { [self] (data, response, error) in
                    guard response is HTTPURLResponse else {
                        DispatchQueue.main.async { [self] in
                            mostRecent.reloadData()
                        }
                        return
                    }
                }
                task.resume()
            }
        }
    }
    
    func checkConnection(){
        if reachability.connection == .unavailable {
            if let data = UserDefaults.standard.data(forKey: "recommendedResult"), let result = try? JSONDecoder().decode([Experiences].self, from: data) {
                viewModel.recommendedResult = result
            }
            if let data = UserDefaults.standard.data(forKey: "recentResult"), let result = try? JSONDecoder().decode([Experiences].self, from: data) {
                viewModel.recentResult = result
            }
            
        } else {
            viewModel.getRecommendedExperiences()
            viewModel.getRecentExperiences()
        }
    }
    
}


