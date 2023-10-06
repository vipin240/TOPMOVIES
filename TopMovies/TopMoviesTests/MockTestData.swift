import Foundation
@testable import TopMovies
import XCTest

class MovieMockData {

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
    
    let movieCell = MovieTableViewCell()
    
    func testMovieCellModel() {
        movieCell.dataPass = moviedetail
        XCTAssertEqual(movieCell.testHooks.titleLbl.text, "The Shawshank Redemption")
        XCTAssertEqual(movieCell.testHooks.yearLbl.text, "1994")
        XCTAssertEqual(movieCell.testHooks.imdbLbl.text, "9.3")
    }

    func testMovieCellNilModel() {
        XCTAssertNil(movieCell.testHooks.titleLbl.text)
      
    }
}
