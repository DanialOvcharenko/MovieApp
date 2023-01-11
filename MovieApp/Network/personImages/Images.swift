//
//  Images.swift
//  MovieApp
//
//  Created by Mac on 08.01.2023.
//

import Foundation

struct Images : Codable, Hashable {
    let file_path : String?
    let vote_average : Double?
    let vote_count : Int?

    enum CodingKeys: String, CodingKey {
        case file_path = "file_path"
        case vote_average = "vote_average"
        case vote_count = "vote_count"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        file_path = try values.decodeIfPresent(String.self, forKey: .file_path)
        vote_average = try values.decodeIfPresent(Double.self, forKey: .vote_average)
        vote_count = try values.decodeIfPresent(Int.self, forKey: .vote_count)
    }

}
