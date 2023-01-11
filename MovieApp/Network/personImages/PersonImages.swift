//
//  PersonImages.swift
//  MovieApp
//
//  Created by Mac on 08.01.2023.
//

import Foundation

import Foundation

struct PersonImages : Codable {
    let id : Int?
    let profiles : [Images]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case profiles = "profiles"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        profiles = try values.decodeIfPresent([Images].self, forKey: .profiles)
    }

}
