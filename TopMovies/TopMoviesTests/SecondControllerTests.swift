//
//  SecondControllerTests.swift
//  TopMoviesTests
//
//  Created by Vipin Jain on 06/10/23.
//

import XCTest
@testable import TopMovies
final class SecondControllerTests: XCTestCase {
    var moviedetail = Movie(rank: 1,
                            title: "The Shawshank Redemption",
                            description: "Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.",
                            image: "https://m.media-amazon.com/images/M/MV5BMDFkYTc0MGEtZmNhMC00ZDIzLWFmNTEtODM1ZmRlYWMwMWFmXkEyXkFqcGdeQXVyMTMxODk2OTU@._Vz1_QL75_UX380_CR0,1,380,562_.jpg",
                            genre: [
                                "Drama"
                            ],
                            rating: "9.3",
                            id: "top1",
                            year: 1994)
    
    
    let movieCell = SecondViewController()
    
    func testMovieScreenModel() {
        movieCell.recieveData = moviedetail
        movieCell.testHooks.configure()
        XCTAssertEqual(movieCell.testHooks.titleLbl.text, "The Shawshank Redemption")
        XCTAssertEqual(movieCell.testHooks.yearLbl.text, " Year: 1994")
        XCTAssertEqual(movieCell.testHooks.imdbLbl.text, "Imdb: 9.3")
    }

    func testMovieCellNilModel() {
        XCTAssertNil(movieCell.testHooks.titleLbl.text)
        XCTAssertNil(movieCell.testHooks.yearLbl.text)
        XCTAssertNil(movieCell.testHooks.imdbLbl.text)

      
    }
}
