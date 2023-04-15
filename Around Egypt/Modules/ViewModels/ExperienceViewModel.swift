//
//  ExperienceViewModel.swift
//  Around Egypt
//
//  Created by Rezk on 15/04/2023.
//

import Foundation
import SwiftUI

struct ExperienceResult : Hashable, Codable {
    let data : Experience
}
struct Experience: Hashable, Codable {
    let title: String
    let cover_photo: String
    let description: String
    let likes_no: Int
    let views_no: Int
    let city : City
}
struct City : Hashable, Codable {
    let name : String
}

class ExperienceViewModel: ObservableObject {
    @Published var experience: Experience?
    func fetch(id: String) {
        guard let url = URL(string: "https://aroundegypt.34ml.com/api/v2/experiences/\(id)") else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "Unknown error")
                return
            }
            do {
                let decodedExperience = try JSONDecoder().decode(ExperienceResult.self, from: data)
                DispatchQueue.main.async {
                    self?.experience = decodedExperience.data
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
