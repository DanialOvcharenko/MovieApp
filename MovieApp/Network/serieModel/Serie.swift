//
//  Serie.swift
//  MovieApp
//
//  Created by Mac on 23.12.2022.
//

import Foundation

struct Serie : Codable {
    let backdrop_path : String?
    let first_air_date : String?
    let genre_ids : [Int]?
    let id : Int?
    let name : String?
    let origin_country : [String]?
    let original_language : String?
    let original_name : String?
    let overview : String?
    let popularity : Double?
    let poster_path : String?
    let vote_average : Double?
    let vote_count : Int?

    enum CodingKeys: String, CodingKey {

        case backdrop_path = "backdrop_path"
        case first_air_date = "first_air_date"
        case genre_ids = "genre_ids"
        case id = "id"
        case name = "name"
        case origin_country = "origin_country"
        case original_language = "original_language"
        case original_name = "original_name"
        case overview = "overview"
        case popularity = "popularity"
        case poster_path = "poster_path"
        case vote_average = "vote_average"
        case vote_count = "vote_count"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        backdrop_path = try values.decodeIfPresent(String.self, forKey: .backdrop_path)
        first_air_date = try values.decodeIfPresent(String.self, forKey: .first_air_date)
        genre_ids = try values.decodeIfPresent([Int].self, forKey: .genre_ids)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        origin_country = try values.decodeIfPresent([String].self, forKey: .origin_country)
        original_language = try values.decodeIfPresent(String.self, forKey: .original_language)
        original_name = try values.decodeIfPresent(String.self, forKey: .original_name)
        overview = try values.decodeIfPresent(String.self, forKey: .overview)
        popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
        poster_path = try values.decodeIfPresent(String.self, forKey: .poster_path)
        vote_average = try values.decodeIfPresent(Double.self, forKey: .vote_average)
        vote_count = try values.decodeIfPresent(Int.self, forKey: .vote_count)
    }

}
