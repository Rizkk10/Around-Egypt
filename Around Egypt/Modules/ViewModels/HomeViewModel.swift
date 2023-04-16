//
//  HomeViewModel.swift
//  Around Egypt
//
//  Created by Rezk on 14/04/2023.
//

import Foundation
import UIKit

class HomeViewModel {
    var recommendedResult: [Experiences] {
        get {
            if let data = UserDefaults.standard.data(forKey: "recommendedResult"), let result = try? JSONDecoder().decode([Experiences].self, from: data) {
                return result
            }
            return []
        }
        set {
            if let encodedData = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(encodedData, forKey: "recommendedResult")
            }
        }
    }

    var recentResult: [Experiences] {
        get {
            if let data = UserDefaults.standard.data(forKey: "recentResult"), let result = try? JSONDecoder().decode([Experiences].self, from: data) {
                return result
            }
            return []
        }
        set {
            if let encodedData = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(encodedData, forKey: "recentResult")
            }
        }
    }
    
    var bindResultToHomeView: (() -> ()) = {}
    
    func getRecommendedExperiences() {
        NetworkManger.fetchData(apiLink: "https://aroundegypt.34ml.com/api/v2/experiences?filter[recommended]=true") { [weak self] (data: Result?) in
            self?.recommendedResult = data?.data ?? []
            self?.bindResultToHomeView()
        }
    }
    
    func getRecentExperiences() {
        NetworkManger.fetchData(apiLink: "https://aroundegypt.34ml.com/api/v2/experiences") { [weak self] (data: Result?) in
            self?.recentResult = data?.data ?? []
            self?.bindResultToHomeView()
        }
    }
}
