//
//  HomeViewModel.swift
//  Around Egypt
//
//  Created by Rezk on 14/04/2023.
//

import Foundation
import UIKit

class HomeViewModel {
    
    var bindResultToHomeView : (() -> ()) = {}
    var recommendedResult : [Experiences] = []{
        didSet{
            bindResultToHomeView()
        }
    }
    func getRecommendedExperiences(){
        
        NetworkManger.fetchData(apiLink: "https://aroundegypt.34ml.com/api/v2/experiences?filter[recommended]=true"){[weak self] (data: Result?) in
            self?.recommendedResult = data?.data ?? []
        }
    }
    var recentResult : [Experiences] = []{
        didSet{
            bindResultToHomeView()
        }
    }
    func getRecentExperiences(){
        
        NetworkManger.fetchData(apiLink: "https://aroundegypt.34ml.com/api/v2/experiences"){[weak self] (data: Result?) in
            self?.recentResult = data?.data ?? []
        }
    }
}
