
import Foundation

struct Person : Codable {
    let adult : Bool?
    let id : Int?
    let name : String?
    let original_name : String?
    let media_type : String?
    let popularity : Double?
    let gender : Int?
    let known_for_department : String?
    let profile_path : String?
    let known_for : [KnownFor]?

    enum CodingKeys: String, CodingKey {

        case adult = "adult"
        case id = "id"
        case name = "name"
        case original_name = "original_name"
        case media_type = "media_type"
        case popularity = "popularity"
        case gender = "gender"
        case known_for_department = "known_for_department"
        case profile_path = "profile_path"
        case known_for = "known_for"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adult = try values.decodeIfPresent(Bool.self, forKey: .adult)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        original_name = try values.decodeIfPresent(String.self, forKey: .original_name)
        media_type = try values.decodeIfPresent(String.self, forKey: .media_type)
        popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
        gender = try values.decodeIfPresent(Int.self, forKey: .gender)
        known_for_department = try values.decodeIfPresent(String.self, forKey: .known_for_department)
        profile_path = try values.decodeIfPresent(String.self, forKey: .profile_path)
        known_for = try values.decodeIfPresent([KnownFor].self, forKey: .known_for)
    }

}
