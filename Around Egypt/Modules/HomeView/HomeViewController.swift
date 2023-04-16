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
    var index = 0 

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
        viewModel.recommendedResult[index].likes_no! += 1 // update likes_no before sending the request
            guard let url = URL(string: "http://aroundegypt.34ml.com/api/v2/experiences/\(String(describing: viewModel.recommendedResult[index].id))/like") else { return }
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
    
    @IBAction func recentLikeTapped(_ sender: Any) {
        viewModel.recentResult[index].likes_no! += 1 // update likes_no before sending the request
            guard let url = URL(string: "http://aroundegypt.34ml.com/api/v2/experiences/\(String(describing: viewModel.recentResult[index].id))/like") else { return }
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


