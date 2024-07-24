//
//  File.swift
//  
//
//  Created by Fep on 22/07/24.
//

import Foundation
import Combine
import Core

public class MoviesPresenter<MoviesUseCase: UseCase>: ObservableObject
where MoviesUseCase.Request == String, MoviesUseCase.Response == [Movie] {
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let _moviesUseCase: MoviesUseCase
    
    @Published public var list: [Movie] = []
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    public init(moviesUseCase: MoviesUseCase) {
        _moviesUseCase = moviesUseCase
    }
    
    public func getMovies(request: MoviesUseCase.Request) {
        isLoading = true
        _moviesUseCase.execute(request: request)
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
            }, receiveValue: { items in
                self.list.append(contentsOf: items)
            })
            .store(in: &cancellables)
    }

}

