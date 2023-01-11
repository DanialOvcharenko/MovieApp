
import Foundation

struct genreResults : Codable {
    let genres : [AllGenres]?

    enum CodingKeys: String, CodingKey {

        case genres = "genres"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        genres = try values.decodeIfPresent([AllGenres].self, forKey: .genres)
    }

}
