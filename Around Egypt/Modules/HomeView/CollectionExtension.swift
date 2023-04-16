//
//  CollectionExtension.swift
//  Around Egypt
//
//  Created by Rezk on 16/04/2023.
//

import Foundation
import UIKit
import SwiftUI

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
        
        index = indexPath.row
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
    
    func renderCollection() {
        self.recommendedExperience.reloadData()
        self.mostRecent.reloadData()
    }
    
}
