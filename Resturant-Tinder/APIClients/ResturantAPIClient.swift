


import Foundation


struct ResturantAPIClient{
    
   
    static func getbusinessesData(categorySearch: String, completionHandler: @escaping (Result<[BusinessesWrapper],AppError>) -> () ) {
        let url = "https://api.yelp.com/v3/businesses/search?term=\(categorySearch)&location=nyc&limit=5"
     
        NetworkHelper.shared.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case .success(let data) :
                do {
                let restInfo = try JSONDecoder().decode(RestaurantInfo.self, from: data)
                completionHandler(.success(restInfo.businesses))
                }
                catch {
                    print(error)
                    completionHandler(.failure(.badJSONError))
                }
            case .failure(let error):
                completionHandler(.failure(.noDataReceived))
            }
        }
     
    }
}





