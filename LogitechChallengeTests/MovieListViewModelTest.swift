//
//  MovieListViewModelTest.swift
//  LogitechChallengeTests
//
//  Created by Anurag on 21/12/18.
//  Copyright © 2018 Anurag. All rights reserved.
//

import XCTest
@testable import LogitechChallenge

class MovieListViewModelTest: XCTestCase {

    var sut: MovieListViewModel!
    var mockAPIService: MockWebService!
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockWebService()
        sut = MovieListViewModel(apiService: mockAPIService)
    }
    
    override func tearDown() {
        sut = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    func testFetchPhoto() {
        // Given
        mockAPIService.completeMovies = [Movie(Title: "TestTitle", Year: nil, Rated: nil, Released: nil, Runtime: nil, Genre: nil, Director: nil, Writer: nil, Actors: nil, Plot: nil, Language: nil, Country: nil, Awards: nil, Poster: "http://www.testphoto.com", PosterWithWhitespace: nil)]
        
        // When
        sut.callApi()
        
        // Assert
        XCTAssert(mockAPIService!.isFetchPopularPhotoCalled)
        XCTAssertNil(sut.alertMessage)
    }
    
    func testFetchPhotoFail() {
        
        // Given a failed fetch with a certain failure
        
        // When
        sut.callApi()
        
        mockAPIService.fetchFail()
        
        // Sut should display error message
        XCTAssertNotNil(sut.alertMessage)
    }
    
    func testCreateCellViewModel() {
        // Given
        let movies = StubGenerator().stubMoviesArray()
        mockAPIService.completeMovies = movies
        let expect = XCTestExpectation(description: "reload closure triggered")
        sut.reloadCollectionViewClosure = { () in
            expect.fulfill()
        }
        
        // When
        sut.callApi()
        mockAPIService.fetchSuccess()
        
        // Number of cell view model is equal to the number of photos
        XCTAssertEqual( sut.numberOfCells, movies.count )
        
        // XCTAssert reload closure triggered
        wait(for: [expect], timeout: 1.0)
    }
    
    func testGetCellViewModel() {
        
        //Given a sut with fetched photos
        goToFetchMovieFinished()
        
        let indexPath = IndexPath(row: 0, section: 0)
        let testMovie = mockAPIService.completeMovies[0]
        
        // When
        let vm = sut.getCellViewModel(at: indexPath)
        
        //Assert
        XCTAssertEqual( vm.thumbnailImageURL, testMovie?.Poster)
    }
    
    func testCellViewModel() {
        //Given movies
        let movie1    = Movie(Title: "TestTitle 1", Year: nil, Rated: nil, Released: nil, Runtime: nil, Genre: nil, Director: nil, Writer: nil, Actors: nil, Plot: nil, Language: nil, Country: nil, Awards: nil, Poster: "http://www.testphoto.com1", PosterWithWhitespace: nil)
        let movie2    = Movie(Title: "TestTitle 2", Year: nil, Rated: nil, Released: nil, Runtime: nil, Genre: nil, Director: nil, Writer: nil, Actors: nil, Plot: nil, Language: nil, Country: nil, Awards: nil, Poster: "http://www.testphoto.com2", PosterWithWhitespace: nil)
        
        // When create cell view model
        let cellViewModel1 = sut.createCellViewModel( movie: movie1 )
        let cellViewModel2 = sut.createCellViewModel( movie: movie2 )
        
        // Assert the correctness of display information
        XCTAssertEqual( movie1.Poster, cellViewModel1.thumbnailImageURL )
        XCTAssertEqual( movie2.Poster, cellViewModel2.thumbnailImageURL )
        
        XCTAssertNotEqual( movie1.Poster, cellViewModel2.thumbnailImageURL )
        
    }
    
    func testProcessFetchedEntries() {
        //Given no movies availabel initially
        XCTAssertEqual(sut.numberOfCells, 0)
        
        // When processFetchedPhoto called
        goToFetchMovieFinished()
        
        XCTAssertEqual(sut.numberOfCells, mockAPIService.completeMovies.count)
        
    }
    
    func testItemSize() {
        let itemSize = sut.itemSize()
        XCTAssertGreaterThan(itemSize, 0)
    }
    
}

// MARK:- State control
extension MovieListViewModelTest {
    private func goToFetchMovieFinished() {
        mockAPIService.completeMovies = StubGenerator().stubMoviesArray()
        sut.callApi()
        mockAPIService.fetchSuccess()
    }
}

// MARK:- Mocking
class MockWebService: WebServiceProtocol {
    
    var isFetchPopularPhotoCalled = false
    
    var completeMovies: [Movie?] = [Movie(Title: "TestTitle", Year: nil, Rated: nil, Released: nil, Runtime: nil, Genre: nil, Director: nil, Writer: nil, Actors: nil, Plot: nil, Language: nil, Country: nil, Awards: nil, Poster: "http://www.testphoto.com", PosterWithWhitespace: nil)]
    var completeClosure: ResultCompletion!
    
    func callApi(completion: @escaping ResultCompletion) {
        isFetchPopularPhotoCalled = true
        completeClosure = completion
    }
    
    func fetchSuccess() {
        completeClosure( completeMovies )
    }
    
    func fetchFail() {
        completeClosure( [] )
    }
    
}

class StubGenerator {
    func stubMoviesArray() -> [Movie] {
        let path = Bundle.main.path(forResource: "response", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        let moviesArray = try! decoder.decode(MovieArray.self, from: data)
        return moviesArray.movie
    }
}
