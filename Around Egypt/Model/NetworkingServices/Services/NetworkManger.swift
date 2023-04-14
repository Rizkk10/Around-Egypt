//
//  NetworkManger.swift
//  Around Egypt
//
//  Created by Rezk on 14/04/2023.
//

import Foundation
import Alamofire

protocol NetworkMangerProtocol {
    static func fetchData<T : Decodable>( apiLink : String ,complitionHandler: @escaping (T?) -> Void)
}

class NetworkManger : NetworkMangerProtocol {
    
    static func fetchData<T : Decodable>(apiLink : String , complitionHandler: @escaping (T?) -> Void){
        
        AF.request(apiLink).response{
            response in
            if let data = response.data {
                do{
                    let result = try JSONDecoder().decode(T.self, from: data)
                    complitionHandler(result)
                }
                catch{
                    complitionHandler(nil)
                }
            }
        }
        
    }
    
}


