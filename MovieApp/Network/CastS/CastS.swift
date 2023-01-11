//
//  CastS.swift
//  MovieApp
//
//  Created by Mac on 07.01.2023.
//

import Foundation

struct CastS : Codable {
    let cast : [Serie]?
    let id : Int?

    enum CodingKeys: String, CodingKey {

        case cast = "cast"
        case id = "id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cast = try values.decodeIfPresent([Serie].self, forKey: .cast)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
    }

}
