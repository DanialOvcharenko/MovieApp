

import Foundation
import SwiftUI



// MARK: - Trending Latest Upcoming NowPlaying Movies
// trending https://api.themoviedb.org/3/trending/movie/week?api_key=d736bf662f23f773be5ced737935827d
// latest https://api.themoviedb.org/3/movie/latest?api_key=d736bf662f23f773be5ced737935827d&language=en-US
// upcoming https://api.themoviedb.org/3/movie/upcoming?api_key=d736bf662f23f773be5ced737935827d&language=en-US&page=1
// nowPlaying https://api.themoviedb.org/3/movie/now_playing?api_key=d736bf662f23f773be5ced737935827d&language=en-US&page=1

class movieModel: Codable {
    var movies: [Movie]!
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        movies = try container.decodeIfPresent([Movie].self, forKey: .results)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(movies, forKey: .results)
    }
}


class movieApi: ObservableObject {
    
    func getMovie(query: String, completion: @escaping (movieModel) -> ()) {
        
        var url = URL(string: query)!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        session.dataTask(with: request as URLRequest) {(data, response, error) in
            if let data = data,
               let results = try? JSONDecoder().decode(movieModel.self, from: data) {
                completion(results)
            }
        }.resume()
    }
}




// MARK: - TopRated Popular OnTheAir AiringToday Series
// TopRated https://api.themoviedb.org/3/tv/top_rated?api_key=d736bf662f23f773be5ced737935827d&language=en-US&page=1
// Popular https://api.themoviedb.org/3/tv/popular?api_key=d736bf662f23f773be5ced737935827d&language=en-US&page=1
// OnTheAir https://api.themoviedb.org/3/tv/on_the_air?api_key=d736bf662f23f773be5ced737935827d&language=en-US&page=1
// AiringToday https://api.themoviedb.org/3/tv/airing_today?api_key=d736bf662f23f773be5ced737935827d&language=en-US&page=1

class serieModel: Codable {
    var series: [Serie]!
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        series = try container.decodeIfPresent([Serie].self, forKey: .results)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(series, forKey: .results)
    }
}


class serieApi: ObservableObject {
    
    func getSerie(query: String, completion: @escaping (serieModel) -> ()) {
        
        var url = URL(string: query)!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        session.dataTask(with: request as URLRequest) {(data, response, error) in
            if let data = data,
               let results = try? JSONDecoder().decode(serieModel.self, from: data) {
                completion(results)
            }
        }.resume()
    }
}


// MARK: - TopRated Persons
// TopRated https://api.themoviedb.org/3/trending/person/week?api_key=d736bf662f23f773be5ced737935827d
// Popular https://api.themoviedb.org/3/person/popular?api_key=d736bf662f23f773be5ced737935827d&language=en-US&page=1

class personModel: Codable {
    var persons: [Person]!
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        persons = try container.decodeIfPresent([Person].self, forKey: .results)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(persons, forKey: .results)
    }
}

class personApi: ObservableObject {
    
    func getPerson(query: String, completion: @escaping (personModel) -> ()) {
        
        var url = URL(string: query)!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        session.dataTask(with: request as URLRequest) {(data, response, error) in
            if let data = data,
               let results = try? JSONDecoder().decode(personModel.self, from: data) {
                completion(results)
            }
        }.resume()
    }
}



// MARK: - Movie Videos
// Querry https://api.themoviedb.org/3/movie/id/videos?api_key=d736bf662f23f773be5ced737935827d&language=en-US
// id = movie.id                             ||

class videoModel: Codable {
    var videos: [Video]!
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        videos = try container.decodeIfPresent([Video].self, forKey: .results)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(videos, forKey: .results)
    }
}


class videoApi: ObservableObject {
    
    func getVideo(query: String, completion: @escaping (videoModel) -> ()) {
        
        var url = URL(string: query)!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        session.dataTask(with: request as URLRequest) {(data, response, error) in
            if let data = data,
               let results = try? JSONDecoder().decode(videoModel.self, from: data) {
                completion(results)
            }
        }.resume()
    }
}


// MARK: - Serie Videos
// Querry https://api.themoviedb.org/3/tv/id/videos?api_key=d736bf662f23f773be5ced737935827d&language=en-US
// id = serie.id                          ||

class serieVideoModel: Codable {
    var videos: [serieVideo]!
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        videos = try container.decodeIfPresent([serieVideo].self, forKey: .results)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(videos, forKey: .results)
    }
}

class videoSerieApi: ObservableObject {
    
    func getSerieVideo(query: String, completion: @escaping (serieVideoModel) -> ()) {
        
        var url = URL(string: query)!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        session.dataTask(with: request as URLRequest) {(data, response, error) in
            if let data = data,
               let results = try? JSONDecoder().decode(serieVideoModel.self, from: data) {
                completion(results)
            }
        }.resume()
    }
}


// MARK: - Genres
// Querry https://api.themoviedb.org/3/genre/movie/list?api_key=d736bf662f23f773be5ced737935827d&language=en-US


class genresModel: Codable {
    var genres: [AllGenres]!
    
    enum CodingKeys: String, CodingKey {
        case genres = "genres"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        genres = try container.decodeIfPresent([AllGenres].self, forKey: .genres)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(genres, forKey: .genres)
    }
}

class genresApi: ObservableObject {
    
    func getGenres(query: String, completion: @escaping (genresModel) -> ()) {
        
        var url = URL(string: query)!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        session.dataTask(with: request as URLRequest) {(data, response, error) in
            if let data = data,
               let results = try? JSONDecoder().decode(genresModel.self, from: data) {
                completion(results)
            }
        }.resume()
    }
}




// MARK: - CastM
// Querry https://api.themoviedb.org/3/person/id/movie_credits?api_key=d736bf662f23f773be5ced737935827d&language=en-US
// id = person.id                             ||


class castModel: Codable {
    var cast: [Movie]!
    
    enum CodingKeys: String, CodingKey {
        case cast = "cast"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cast = try container.decodeIfPresent([Movie].self, forKey: .cast)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(cast, forKey: .cast)
    }
}

class castApi: ObservableObject {
    
    func getCast(query: String, completion: @escaping (castModel) -> ()) {
        
        var url = URL(string: query)!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        session.dataTask(with: request as URLRequest) {(data, response, error) in
            if let data = data,
               let results = try? JSONDecoder().decode(castModel.self, from: data) {
                completion(results)
            }
        }.resume()
    }
}



// MARK: - CastS
// Querry https://api.themoviedb.org/3/person/id/tv_credits?api_key=d736bf662f23f773be5ced737935827d&language=en-US
// id = person.id                             ||


class castSModel: Codable {
    var cast: [Serie]!
    
    enum CodingKeys: String, CodingKey {
        case cast = "cast"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cast = try container.decodeIfPresent([Serie].self, forKey: .cast)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(cast, forKey: .cast)
    }
}

class castSApi: ObservableObject {
    
    func getCast(query: String, completion: @escaping (castSModel) -> ()) {
        
        var url = URL(string: query)!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        session.dataTask(with: request as URLRequest) {(data, response, error) in
            if let data = data,
               let results = try? JSONDecoder().decode(castSModel.self, from: data) {
                completion(results)
            }
        }.resume()
    }
}


// MARK: - MovieCast
// Querry https://api.themoviedb.org/3/movie/id/credits?api_key=d736bf662f23f773be5ced737935827d&language=en-US
// id = movie.id                             ||

class movieCastModel: Codable {
    var cast: [Person]!
    
    enum CodingKeys: String, CodingKey {
        case cast = "cast"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cast = try container.decodeIfPresent([Person].self, forKey: .cast)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(cast, forKey: .cast)
    }
}

class movieCastApi: ObservableObject {
    
    func getMovieCast(query: String, completion: @escaping (movieCastModel) -> ()) {
        
        var url = URL(string: query)!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        session.dataTask(with: request as URLRequest) {(data, response, error) in
            if let data = data,
               let results = try? JSONDecoder().decode(movieCastModel.self, from: data) {
                completion(results)
            }
        }.resume()
    }
}


// MARK: - SerieCast
// Querry https://api.themoviedb.org/3/tv/id/credits?api_key=d736bf662f23f773be5ced737935827d&language=en-US
// id = serie.id                          ||

class serieCastModel: Codable {
    var cast: [Person]!
    
    enum CodingKeys: String, CodingKey {
        case cast = "cast"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cast = try container.decodeIfPresent([Person].self, forKey: .cast)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(cast, forKey: .cast)
    }
}

class serieCastApi: ObservableObject {
    
    func getSerieCast(query: String, completion: @escaping (serieCastModel) -> ()) {
        
        var url = URL(string: query)!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        session.dataTask(with: request as URLRequest) {(data, response, error) in
            if let data = data,
               let results = try? JSONDecoder().decode(serieCastModel.self, from: data) {
                completion(results)
            }
        }.resume()
    }
}



// MARK: - Person Images
// Querry https://api.themoviedb.org/3/person/id/images?api_key=d736bf662f23f773be5ced737935827d
// id = person.id                             ||

class personImageModel: Codable {
    var profiles: [Images]!
    
    enum CodingKeys: String, CodingKey {
        case profiles = "profiles"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        profiles = try container.decodeIfPresent([Images].self, forKey: .profiles)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(profiles, forKey: .profiles)
    }
}

class personImageApi: ObservableObject {
    
    func getPersonImages(query: String, completion: @escaping (personImageModel) -> ()) {
        
        var url = URL(string: query)!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        session.dataTask(with: request as URLRequest) {(data, response, error) in
            if let data = data,
               let results = try? JSONDecoder().decode(personImageModel.self, from: data) {
                completion(results)
            }
        }.resume()
    }
}


// MARK: - Movie Recomendations
// Querry https://api.themoviedb.org/3/movie/id/recommendations?api_key=d736bf662f23f773be5ced737935827d&language=en-US&page=1
// id = movie.id                             ||

class movieRecomendationsModel: Codable {
    var results: [Movie]!
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        results = try container.decodeIfPresent([Movie].self, forKey: .results)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(results, forKey: .results)
    }
}

class movieRecomendationsApi: ObservableObject {
    
    func getMovieRecomendations(query: String, completion: @escaping (movieRecomendationsModel) -> ()) {
        
        var url = URL(string: query)!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        session.dataTask(with: request as URLRequest) {(data, response, error) in
            if let data = data,
               let results = try? JSONDecoder().decode(movieRecomendationsModel.self, from: data) {
                completion(results)
            }
        }.resume()
    }
}



// MARK: - Series Recomendations
// Querry https://api.themoviedb.org/3/tv/id/recommendations?api_key=d736bf662f23f773be5ced737935827d&language=en-US&page=1
// id = serie.id                          ||

class serieRecomendationsModel: Codable {
    var results: [Serie]!
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        results = try container.decodeIfPresent([Serie].self, forKey: .results)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(results, forKey: .results)
    }
}

class serieRecomendationsApi: ObservableObject {
    
    func getSerieRecomendations(query: String, completion: @escaping (serieRecomendationsModel) -> ()) {
        
        var url = URL(string: query)!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        session.dataTask(with: request as URLRequest) {(data, response, error) in
            if let data = data,
               let results = try? JSONDecoder().decode(serieRecomendationsModel.self, from: data) {
                completion(results)
            }
        }.resume()
    }
}
