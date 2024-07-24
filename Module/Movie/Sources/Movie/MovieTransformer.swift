import Core
import RealmSwift
import Movie

public struct MovieTransformerMapper: Mapper{
    
    public typealias Request = String
    public typealias Response = Movie
    public typealias Entity = MovieObject
    public typealias Domain = Movie
    
    public init() {}
    
    public func transformResponseToEntity(request: String?, response: Movie) -> MovieObject {
        return response.toClass()
    }
    
    public func transformEntityToDomain(entity: MovieObject) -> Movie {
        return entity.toStruct()
    }
}
