//
//  DataModel.swift
//  Around Egypt
//
//  Created by Rezk on 14/04/2023.
//

import Foundation

class Result : Decodable {
    
    var data : [Experiences]
}

class Experiences : Decodable , Encodable {
    var title : String?
    var id : String?
    var cover_photo : String?
    var description : String?
    var views_no : Int?
    var likes_no : Int?
    
}

