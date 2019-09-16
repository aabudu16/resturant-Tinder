


import Foundation


struct ResturantAPIClient{
    
   
    static func getbusinessesData(completionHandler: @escaping (Result<[RestaurantInfo],AppError>) -> () ) {
        let url = "https://api.yelp.com/v3/businesses/search?term=restaurant&location=nyc"
     
        NetworkHelper.shared.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case .success(let data) :
                do {
                let restInfo = try JSONDecoder().decode([RestaurantInfo].self, from: data)
                completionHandler(.success(restInfo))
                }
                catch {
                    completionHandler(.failure(.badJSONError))
                }
            case .failure(let error):
                completionHandler(.failure(.noDataReceived))
            }
        }
     
    }
}





