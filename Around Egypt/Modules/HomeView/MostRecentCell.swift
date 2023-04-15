//
//  MostRecentCell.swift
//  Around Egypt
//
//  Created by Rezk on 14/04/2023.
//

import UIKit

class MostRecentCell: UICollectionViewCell {
    
    @IBOutlet weak var mostRecentImage: UIImageView!
    
    @IBOutlet weak var mostRecentTitle: UILabel!
    
    @IBOutlet weak var mostRecentLikes: UILabel!
    
    func configCell(experience: Experiences){
        mostRecentTitle.text = experience.title
        mostRecentLikes.text = String(experience.likes_no ?? 0)
        self.layer.cornerRadius = 25
        self.layer.masksToBounds = true
        self.contentView.layer.masksToBounds = true
        
        let url = URL(string: experience.cover_photo!)
        mostRecentImage.kf.indicatorType = .activity
        mostRecentImage.kf.setImage(with: url)
    }
}
