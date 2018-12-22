//
//  MovieDetailViewModelTest.swift
//  LogitechChallengeTests
//
//  Created by Anurag on 22/12/18.
//  Copyright © 2018 Anurag. All rights reserved.
//

import XCTest
import Foundation
@testable import LogitechChallenge

class MovieDetailViewModelTest: XCTestCase {
    var sut: MovieDetailViewModel!
    
    override func setUp() {
        super.setUp()
        let movies = StubGenerator().stubMoviesArray()
        sut = MovieDetailViewModel(movie: movies[0])
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testFetchMovieImage() {
        XCTAssertNotNil(sut.imageUrl())
        XCTAssertNotEqual(sut.imageUrl(), "http://testImageUrl.com")
        
        XCTAssertEqual(sut.imageUrl(), sut.movie.Poster)
    }
    
    func testMovieDetails() {
        XCTAssertNotNil(sut.movieDetails())
        XCTAssertNotNil(sut.movieDetails().contains(sut.movie.Actors!))
    }
}
