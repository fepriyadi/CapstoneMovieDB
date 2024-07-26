//
//  CapstoneDicodingTests.swift
//  CapstoneDicodingTests
//
//  Created by Fep on 24/07/24.
//

import Quick
import Nimble
import Movie
import Core
import Combine

@testable import CapstoneDicoding
import Foundation

final class GetMoviesRepoTests: QuickSpec {
    override func spec() {
    
        describe("GetMoviesRepository") {
            var mockdatasource: GetMoviesDataSource!
            var mockrepo: GetMoviesRepository<GetMoviesDataSource>!
            var cancellables: Set<AnyCancellable> = []
            
            beforeEach {
//                let user = User(name: "John Doe")
                mockdatasource = GetMoviesDataSource(endpoint: Endpoints.Gets.movies.url)
                mockrepo = GetMoviesRepository(remoteDataSource: mockdatasource)
            }
            
            context("fetching movies") {
                it("should return movies") {
                    // Set up the expectation
                    var receivedMovies: [Movie]?
                    var receivedError: Error?
                    
                    let expectation = self.expectation(description: "Fetch movies by endpoint")
                    
                    mockrepo.execute(request: "now_playing")
                        .sink(receiveCompletion: { completion in
                            if case .failure(let error) = completion {
                                receivedError = error
                            }
                            expectation.fulfill()
                        }, receiveValue: { movies in
                            receivedMovies = movies
                        })
                        .store(in: &cancellables)
                    
                    self.waitForExpectations(timeout: 1.0) { _ in
                        expect(receivedMovies).toNot(beEmpty())
//                        expect(receivedUser?.name) == "John Doe"
                        expect(receivedError).to(beNil())
                    }
                }
                
                it("should handle errors properly") {
                    // Adjust UserDataSource to simulate an error
                    let failingDataSource = FailingUserDataSource()
                    
                    var receivedError: Error?
                    
                    let expectation = self.expectation(description: "Fetch movies by endpoint failure")
                    
                    mockrepo.execute(request: nil)
                        .sink(receiveCompletion: { completion in
                            if case .failure(let error) = completion {
                                receivedError = error
                            }
                            expectation.fulfill()
                        }, receiveValue: { _ in
                            // This should not be called
                            fail("Unexpected success")
                        })
                        .store(in: &cancellables)
                    
                    self.waitForExpectations(timeout: 1.0) { _ in
                        expect(receivedError).toNot(beNil())
                    }
                }
            }
        }
        
    }
}


class FailingUserDataSource: DataSource {
    func execute(request: String?) -> AnyPublisher<[Movie], Error> {
        return Fail(error: NSError(domain: "", code: -1, userInfo: nil))
            .eraseToAnyPublisher()
    }
}
