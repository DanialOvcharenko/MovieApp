//
//  MovieCast.swift
//  MovieApp
//
//  Created by Mac on 07.01.2023.
//

import Foundation

struct MovieCast : Codable {
    let id : Int?
    let cast : [Person]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case cast = "cast"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        cast = try values.decodeIfPresent([Person].self, forKey: .cast)
    }

}
