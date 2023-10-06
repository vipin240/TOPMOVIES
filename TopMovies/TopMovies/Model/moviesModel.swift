//
//  moviesViewModel.swift
//  TopMovies
//
//  Created by Vipin Jain on 25/09/23.
//

import Foundation

/*struct moviesModel : Decodable{
    let title :String
    let rank : String
    let description : String
    let director : String
    let year :String
    
    private enum CodingKeys : String, CodingKey{
        case title
        case rank
        case description
        case director
        case year 
    }
}*/

struct Movie: Codable {
    let rank: Int
    let title: String
    let description: String
    let image: String
  
    let genre: [String]
    let rating: String
    let id: String
    let year: Int
   
}

