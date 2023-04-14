//
//  RecommendedExperiencesCell.swift
//  Around Egypt
//
//  Created by Rezk on 14/04/2023.
//

import UIKit
import Kingfisher

class RecommendedExperiencesCell: UICollectionViewCell {
    
    @IBOutlet weak var experienceTitle: UILabel!
    
    @IBOutlet weak var experirnceImage: UIImageView!
    
    @IBOutlet weak var experienceLikes: UILabel!
    
    func configCell(experience: Experiences){
        experienceTitle.text = experience.title
        experienceLikes.text = String(experience.likes_no ?? 0)
        self.layer.borderColor = UIColor.systemGray.cgColor
        self.layer.borderWidth = 0.4
        self.layer.cornerRadius = 25
        self.layer.masksToBounds = true
        self.contentView.layer.masksToBounds = true
        
        let url = URL(string: experience.cover_photo!)
        experirnceImage.kf.indicatorType = .activity
        experirnceImage.kf.setImage(with: url)
    }
}
