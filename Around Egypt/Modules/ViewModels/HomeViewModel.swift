//
//  HomeViewModel.swift
//  Around Egypt
//
//  Created by Rezk on 14/04/2023.
//

import Foundation
import UIKit

class HomeViewModel {
    let cache = NSCache<NSString, NSArray>()
    var bindResultToHomeView : (() -> ()) = {}
    var recommendedResult : [Experiences] = []{
        didSet{
            bindResultToHomeView()
        }
    }
    func getRecommendedExperiences() {
            if let cachedData = cache.object(forKey: "recommendedExperiences") as? [Experiences] {
                self.recommendedResult = cachedData
                return
            }

            NetworkManger.fetchData(apiLink: "https://aroundegypt.34ml.com/api/v2/experiences?filter[recommended]=true") { [weak self] (data: Result?) in
                self?.recommendedResult = data!.data
                self?.cache.setObject(self?.recommendedResult as NSArray? ?? NSArray(), forKey: "recommendedExperiences")
                self?.bindResultToHomeView()
            }
        }
    
    var recentResult : [Experiences] = []{
        didSet{
            bindResultToHomeView()
        }
    }
    func getRecentExperiences() {
            if let cachedData = cache.object(forKey: "recentExperiences") as? [Experiences] {
                self.recentResult = cachedData
                return
            }

            NetworkManger.fetchData(apiLink: "https://aroundegypt.34ml.com/api/v2/experiences") { [weak self] (data: Result?) in
                self?.recentResult = data!.data
                self?.cache.setObject(self?.recentResult as NSArray? ?? NSArray(), forKey: "recentExperiences")
                self?.bindResultToHomeView()
            }
        }
}
