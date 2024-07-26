//
//  File.swift
//  
//
//  Created by Fep on 15/07/24.
//
import Foundation
import RealmSwift

public struct ProductionCompany: Codable {
    let id: Int
    let logoPath, name: String?
    let originCountry: String?

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

// MARK: - ProductionCountry
public struct ProductionCountry: Codable {
    let iso3166_1: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

public struct SpokenLanguage: Codable {
    let englishName: String?
    let iso639_1: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}

public struct Belong: Codable {
    var id: Int = 0
    var name: String? = ""
    var posterPath: String? = nil
    var backdropPath: String? = nil

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}

public struct MovieGenre: Codable {
    var id: Int? = 0
    var name: String? = ""
}

public struct MovieCredit: Codable {
    var cast: [MovieCast]
    var crew: [MovieCrew]
}

public struct MovieCast: Codable, Identifiable {
    public var adult: Bool?
    public var gender: Int?
    public var id: Int
    public var knownForDepartment, originalName: String?
    public var name: String
    public var popularity: Double?
    public var profilePath: String?
    public var castID: Int?
    public var character: String
    public var creditID: String?
    public var order: Int?
    var department, job: String?
    
    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order, department, job
    }
    
    init(id: Int, character: String, name: String) {
        self.id = id
        self.character = character
        self.name = name
    }
}

public struct MovieCrew: Codable, Identifiable {
    public var adult: Bool?
    public var gender: Int?
    public var id: Int
    public var knownForDepartment, originalName: String?
    public var name: String
    public var popularity: Double?
    public var profilePath: String?
    public var castID: Int?
    public var character: String?
    public var creditID: String?
    public var order: Int?
    public var department: String?
    public var job: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order, department, job
    }
}

public struct MovieVideoResponse: Codable {
    
    public var results: [MovieVideo]
}

public struct MovieVideo: Codable, Identifiable {
    
    public var iso639_1: String?
    public var iso3166_1: String?
    public var name, key: String
    public var site: String
    public var size: Int?
    public var type: String?
    public var official: Bool?
    public var publishedAt: String?
    public var id: String
    
    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
    
    public var youtubeURL: URL? {
        guard site == "YouTube" else {
            return nil
        }
        return URL(string: "https://youtube.com/watch?v=\(key)")
    }
    
    init(id: String, key: String, name: String, site: String) {
        self.id = id
        self.key = key
        self.name = name
        self.site = site
    }
}

public extension Movie {
    init(from movieObject: MovieObject) {
        self.id = movieObject.id
        self.title = movieObject.title
        self.backdropPath = movieObject.backdropPath
        self.posterPath = movieObject.posterPath
        self.overview = movieObject.overview
        self.genreText = movieObject.genre
        self.yearText = ""
        self.ratingText = ""
        self.scoreText = ""
        self.cast = movieObject.cast.map{ $0.toStruct() }
        self.crew = movieObject.crew.map{ $0.toStruct() }
        self.youtubeTrailers = movieObject.trailer.map{ $0.toStruct() }
        self.isfavorite = movieObject.favorite
    }
    
    init(from movie: Movie, source: MovieListEndpoint?) {
        
        self.id = movie.id
        self.title = movie.title
        self.backdropPath = movie.backdropPath
        self.posterPath = movie.posterPath
        self.overview = movie.overview
        self.genres = movie.genres
        self.credits = movie.credits
        self.videos = movie.videos
        self.voteAverage = movie.voteAverage
        self.voteCount = movie.voteCount
        self.cast = movie.cast
        self.crew = movie.crew
        self.trailerList = movie.trailerList
        
        self.originCountry = movie.originCountry
        self.revenue = movie.revenue
        self.adult = movie.adult
        self.source = source
        self.budget = movie.budget
        self.homepage = movie.homepage
        self.originalLanguage = movie.originalLanguage
        self.originalTitle = movie.originalTitle
        self.popularity = movie.popularity
        self.releaseDate = movie.releaseDate
        self.runtime = movie.runtime
        self.status = movie.status
        self.tagline = movie.tagline
    }
    
    public func toClass() -> MovieObject {
        return MovieObject(
            id: self.id,
            title: self.title,
            backdropPath: self.backdropPath,
            posterPath: self.posterPath,
            overview: self.overview,
            genre: self.genreText,
            year: self.yearText,
            duration: self.durationText,
            rating: self.ratingText,
            score: self.scoreText,
            cast: self.castList,
            crew: self.crewList,
            trailer: self.trailerList,
            favorite: self.isfavorite ?? false
        )
    }
}

extension MovieCast {
    init(from movieCast: MovieCastObject) {
        self.id = movieCast.id
        self.character = movieCast.character
        self.name = movieCast.name
    }
    
    func toClass() -> MovieCastObject {
        return MovieCastObject(
            id: self.id,
            character: self.character,
            name: self.name
        )
    }
}

extension MovieCrew {
    init(from movieCrew: MovieCrewObject) {
        self.id = movieCrew.id
        self.job = movieCrew.job
        self.name = movieCrew.name
    }
    
    func toClass() -> MovieCrewObject {
        return MovieCrewObject(
            id: self.id,
            job: self.job ?? "",
            name: self.name
        )
    }
}

extension MovieVideo {
    init(from movieVideo: MovieVideoObject) {
        self.id = movieVideo.id
        self.key = movieVideo.key
        self.name = movieVideo.name
        self.site = movieVideo.site
    }
    
    func toClass() -> MovieVideoObject {
        return MovieVideoObject(
            id: self.id,
            key: self.key,
            name: self.name,
            site: self.site
        )
    }
}

