//
//  Cast.swift
//  MovieApp
//
//  Created by Mac on 06.01.2023.
//

import Foundation

struct CastM : Codable {
    let cast : [Movie]?
    let id : Int?

    enum CodingKeys: String, CodingKey {

        case cast = "cast"
        case id = "id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cast = try values.decodeIfPresent([Movie].self, forKey: .cast)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
    }

}
