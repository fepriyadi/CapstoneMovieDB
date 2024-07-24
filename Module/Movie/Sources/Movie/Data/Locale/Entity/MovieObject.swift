//
//  File.swift
//  
//
//  Created by Fep on 15/07/24.
//

import Foundation
import RealmSwift

public class MovieObject: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var backdropPath = ""
    @objc dynamic var posterPath = ""
    @objc dynamic var overview = ""
    @objc dynamic var genre = ""
    @objc dynamic var year = ""
    @objc dynamic var duration = ""
    @objc dynamic var rating = ""
    @objc dynamic var score = ""
    var cast = List<MovieCastObject>()
    var crew = List<MovieCrewObject>()
    var trailer = List<MovieVideoObject>()
    
    @objc dynamic public var favorite = false
    
    public override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: Int, title: String, backdropPath: String, posterPath: String, overview: String, genre: String, year: String, duration: String, rating: String, score: String, cast: List<MovieCastObject>, crew: List<MovieCrewObject>, trailer: List<MovieVideoObject>, favorite: Bool) {
        self.init()
        self.id = id
        self.title = title
        self.backdropPath = backdropPath
        self.posterPath = posterPath
        self.overview = overview
        self.genre = genre
        self.year = year
        self.duration = duration
        self.rating = rating
        self.score = score
        self.cast = cast
        self.crew = crew
        self.trailer = trailer
        self.favorite = favorite
        }
}

public class MovieCastObject: Object {
    @objc dynamic var id = 0
    @objc dynamic var character = ""
    @objc dynamic var name = ""
    
    convenience init(id: Int = 0, character: String = "", name: String = "") {
        self.init()
        self.id = id
        self.character = character
        self.name = name
    }
}

public class MovieCrewObject: Object {
    @objc dynamic var id =  0
    @objc dynamic var job = ""
    @objc dynamic var name = ""
    
    convenience init(id: Int = 0, job: String = "", name: String = "") {
        self.init()
        self.id = id
        self.job = job
        self.name = name
    }
}

public class MovieVideoObject: Object {
    
    @objc dynamic var id = ""
    @objc dynamic var key = ""
    @objc dynamic var name = ""
    @objc dynamic var site = ""
    
    @objc dynamic var youtubeURL: URL? {
        guard site == "YouTube" else {
            return nil
        }
        return URL(string: "https://youtube.com/watch?v=\(key)")
    }
    
    convenience init(id: String = "", key: String = "", name: String = "", site: String = "") {
        self.init()
        self.id = id
        self.key = key
        self.name = name
        self.site = site
    }
}

extension MovieCastObject {
    convenience init(from movieCast: MovieCast) {
        self.init(
            id: movieCast.id,
            character: movieCast.character,
            name: movieCast.name
        )
    }
    
    func toStruct() -> MovieCast {
        return MovieCast(
            id: self.id,
            character: self.character,
            name: self.name
        )
    }
}

extension MovieCrewObject {
    convenience init(from movieCrew: MovieCrew) {
        self.init(
            id: movieCrew.id,
            job: movieCrew.job ?? "",
            name: movieCrew.name
        )
    }
    
    func toStruct() -> MovieCrew {
        return MovieCrew(
            id: self.id,
            name: self.name,
            job: self.job
        )
    }
}

extension MovieVideoObject {
    convenience init(from movieVideo: MovieVideo) {
        self.init(
            id: movieVideo.id,
            key: movieVideo.key,
            name: movieVideo.name,
            site: movieVideo.site
        )
    }
    
    func toStruct() -> MovieVideo {
        return MovieVideo(
            id: self.id,
            key: self.key,
            name: self.name,
            site: self.site
        )
    }
}

extension MovieObject {
    convenience init(from movie: Movie) {
        self.init(
            id: movie.id,
            title: movie.title,
            backdropPath: movie.backdropPath,
            posterPath: movie.posterPath,
            overview: movie.overview,
            genre: movie.genreText,
            year: movie.yearText,
            duration: movie.durationText,
            rating: movie.ratingText,
            score: movie.scoreText,
            cast: movie.castList,
            crew: movie.crewList,
            trailer: movie.trailerList,
            favorite: movie.isfavorite ?? false
        )
    }
    
    public func toStruct() -> Movie {
        return Movie(from: MovieObject(id: self.id,
                                       title: self.title,
                                       backdropPath: self.backdropPath,
                                       posterPath: self.posterPath,
                                       overview: self.overview,
                                       genre: self.genre,
                                       year: self.year,
                                       duration: self.duration,
                                       rating: self.rating,
                                       score: self.score,
                                       cast: self.cast,
                                       crew: self.crew,
                                       trailer: self.trailer,
                                       favorite: self.favorite
                                      ))
    }
}

