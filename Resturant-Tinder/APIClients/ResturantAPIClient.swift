


import Foundation


struct ResturantAPIClient{
    
    static func getbusinessesData(completionHandler: @escaping (Result<[RestarantInfo],AppError>) -> () ) {
        let url = "https://api.yelp.com/v3/businesses/search?term=restaurant&location=nyc"
        
        NetworkManager.shared.fetchData(urlString: url) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let businessesData = try JSONDecoder().decode([RestarantInfo].self, from: data)
                    completionHandler(.success(businessesData))
                } catch {
                    completionHandler(.failure(.badJSONError))
                    
                }
            }
        }
    }
}





