//
//  File.swift
//  
//
//  Created by Fep on 15/07/24.
//

import Foundation
import Combine
import Core
import Movie

public class MoviePresenter<MovieUseCase: UseCase, FavUseCase: FavoriteUseCase>: ObservableObject
where
MovieUseCase.Request == String, MovieUseCase.Response == Movie,
FavUseCase.Request == String, FavUseCase.Response == MovieObject
{
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let _movieUseCase: MovieUseCase
    private let _favoriteUseCase: FavUseCase
    
    @Published public var item: Movie?
    @Published public var movieObj: MovieObject?
    @Published public var errorMessage: String = ""
    @Published public var msg: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    @Published public var isShowing: Bool = false
    
    public init(movieUseCase: MovieUseCase, favoriteUseCase: FavUseCase) {
        _movieUseCase = movieUseCase
        _favoriteUseCase = favoriteUseCase
    }
    
    public func getMovie(request: MovieUseCase.Request) {
        isLoading = true
        _movieUseCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure (let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { item in
                self.item = item
            })
            .store(in: &cancellables)
    }
    
    public func isFavorite(id: Int) {
        self.movieObj = nil
        isLoading = true
        _favoriteUseCase.get(id: id)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure (let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { item in
                self.movieObj = item
            })
            .store(in: &cancellables)
    }
    
    public func addFavorite(request: MovieObject) {
        isLoading = true
        _favoriteUseCase.addFavorite(entity: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure (let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { item in
                self.movieObj = item
                self.isShowing = true
                self.msg = "Add to Favorite successfull"
            })
            .store(in: &cancellables)
    }
    
    public func removeFavorite(request: MovieObject) {
        isLoading = true
        _favoriteUseCase.removeFavorite(entity: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure (let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { item in
                self.movieObj = nil
                self.isShowing = true
                self.msg = "Remove from Favorite successfull"
            })
            .store(in: &cancellables)
    }

}
