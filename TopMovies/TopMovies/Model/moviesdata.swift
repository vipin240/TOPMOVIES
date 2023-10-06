import Foundation

let headers = [
    "X-RapidAPI-Key": "72e1b04f59mshc865ce714183f00p146cf2jsnd669b8e58153",
    //"X-RapidAPI-Host": "imdb-top-100-movies.p.rapidapi.com"
]
// Define the Person struct


class NetworkManager {
    //    let session = URLSession.shared
    
    func callAPI(completion: @escaping([Movie]) -> Void) {
        let request = NSMutableURLRequest(url: NSURL(string: "https://imdb-top-100-movies.p.rapidapi.com/")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
                guard let jsonData = data, !jsonData.isEmpty else {
                    print("No data received from the API")
                    return
                }

                do {
                    // Try to decode the JSON data into an array of Movie objects
                     
                    do {
                        let decoder = JSONDecoder()
                        let movies = try decoder.decode([Movie].self, from: jsonData)
                        for movie in movies {
                            print(movie.title)
                        }
                        completion(movies)
                        // Now, 'people' contains an array of Person objects
                        
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }

                        // Now you can safely iterate over the array of Movie objects
//                    if let movies = movies {
//                        let count = movies.count
//                        print("Number of movies: \(count)")
//                    } else {
//                        print("Movies array is nil")
//                    }
//                    movies?.forEach { testM in
//                                    // do whatever you want here
//                        print(testM.title)
//
//                    }

                } catch let decodingError as DecodingError {
                    print("Decoding error: \(decodingError.localizedDescription)")
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
 
 
           

        })

        dataTask.resume()
        
    }
    
    
}



