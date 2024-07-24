//
//  File.swift
//  
//
//  Created by Fep on 16/07/24.
//

import Foundation
import RealmSwift

public struct MovieResponse: Decodable {
    public var results: [Movie]
}


public struct Movie: Decodable, Identifiable, Hashable {
    
    enum CodingKeys: String, CodingKey {
        case adult
        case _backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget, genres, homepage
        case _genreIDs = "genre_ids"
        case id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case originCountry = "origin_country"
        case _overview = "overview"
        case popularity
        case _posterPath = "poster_path"
        case releaseDate = "release_date"
        case runtime, status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case revenue, videos, credits
        case spokenLanguages = "spoken_languages"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
    }
    
    var productionCountries: [ProductionCountry]?
    var productionCompanies: [ProductionCompany]?
    var spokenLanguages: [SpokenLanguage]?
    public var originCountry: [String]?
    public var revenue: Int? = 0
    public var adult: Bool? = false
    public var source: MovieListEndpoint?
    var belongsToCollection: Belong? = nil
    public var budget: Int? = 0
    public var homepage: String? = nil
    public var id: Int = 0
    public var imdbID: String? = nil
    public var originalLanguage: String? = ""
    public var originalTitle: String? = ""
    public var popularity: Double? = 0.0
    public var releaseDate: String = ""
    public var runtime: Int? = nil
    public var status: String? = nil
    public var tagline: String? = nil
    public var title: String = ""
    public var video: Bool? = false
    public var isfavorite: Bool? = false
    public var voteAverage: Double? = 0.0
    public var voteCount: Int? = 0
    
    var genres: [MovieGenre]? = []
    var credits: MovieCredit? = MovieCredit(cast: [], crew: [])
    var videos: MovieVideoResponse? = MovieVideoResponse(results: [])
    
    public static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    private var _backdropPath: String? = nil
    private var _posterPath: String? = nil
    private var _overview: String? = nil
    private var _genreIDs: [Int]? = []
    
    var genreIDs: [Int]? {
        get {
            return _genreIDs ?? []
        }
        set {
            _genreIDs = newValue
        }
    }
    
    var backdropPath: String {
        get {
            return _backdropPath ?? "" // Default value if _backdropPath is nil
        }
        set {
            _backdropPath = newValue
        }
    }
    
    public var overview: String {
        get {
            return _overview ?? "" // Default value if _backdropPath is nil
        }
        set {
            _overview = newValue
        }
    }
    
    var posterPath: String {
        get {
            return _posterPath ?? "" // Default value if _backdropPath is nil
        }
        set {
            _posterPath = newValue
        }
    }
    
    public var durationText: String {
        get{
            guard let runtime = self.runtime, runtime > 0 else {
                return "n/a"
            }
            return Movie.durationFormatter.string(from: TimeInterval(runtime) * 60) ?? "n/a"
        }
        set{ }
    }
    
    static private var yearFormatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    static private var durationFormatter: DateComponentsFormatter = {
        var formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour, .minute]
        return formatter
    }()
    
    public var backdropURL: URL {
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(String(describing: backdropPath))")!
        return url
    }
    
    public var posterURL: URL {
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(String(describing: posterPath))")!
        return url
    }
    
    public var genreText: String {
        get{
            genres?.first?.name ?? "n/a"
        }
        
        set{
            self.genres = [MovieGenre(name: newValue)]
        }
    }
    
    public var ratingText: String {
        get{
            let rating = Int(voteAverage ?? 0)
            let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
                return acc + "★"
            }
            return ratingText
        }
        set{ }
    }
    
    public var scoreText: String {
        get{
            guard ratingText.count > 0 else {
                return "n/a"
            }
            return "\(ratingText.count)/10"
        }
        
        set{ }
    }
    
    public var yearText: String {
        get{
            if let date = Utils.dateFormatter.date(from: self.releaseDate) {
                return Movie.yearFormatter.string(from: date)
            }else{
                return "n/a"
            }
           
        }
        set{ }
    }
    
    public var cast: [MovieCast] {
        get{
            credits?.cast ?? [MovieCast]()
        }
        set{ }
    }
    
    var castList: List<MovieCastObject>{
        get{
            let list = List<MovieCastObject>()
            guard let cast = credits?.cast else {
                return list
            }
            let arrMovieCastObj = cast.map { $0.toClass() }
            arrMovieCastObj.forEach { obj in list.append(obj) }
            return list
        }
    }
    
    public var crew: [MovieCrew] {
        get{
            credits?.crew ?? [MovieCrew]()
        }
        set{ }
    }
    
    var crewList: List<MovieCrewObject>{
        get{
            let list = List<MovieCrewObject>()
            guard let crew = credits?.crew else {
                return List<MovieCrewObject>()
            }
            let arrMovieCrewObj = crew.map { $0.toClass() }
            arrMovieCrewObj.forEach { obj in list.append(obj) }
            return list
        }
    }
    
    public var directors: [MovieCrew] {
        get{
            crew.filter { $0.job?.lowercased() == "director" }
        }
    }
    
    public var producers: [MovieCrew]? {
        get{
            crew.filter { $0.job?.lowercased() == "producer" }
        }
    }
    
    public var screenWriters: [MovieCrew]? {
        crew.filter { $0.job?.lowercased() == "story" }
    }
    
    public var youtubeTrailers: [MovieVideo] {
        get{
            guard let trailers = videos?.results else{
                return [MovieVideo]()
            }
            return trailers.filter { $0.youtubeURL != nil }
        }
        set{ }
    }
    
    var trailerList: List<MovieVideoObject>{
        get{
            let list = List<MovieVideoObject>()
            guard let trailers = videos?.results else {
                return List<MovieVideoObject>()
            }
            let arrMovieTrailerObj = trailers.map { $0.toClass() }
            arrMovieTrailerObj.forEach { obj in list.append(obj) }
            return list
        }
        set{ }
    }
    
    
    
}


