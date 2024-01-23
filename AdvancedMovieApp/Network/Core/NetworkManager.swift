
import Alamofire
import Foundation

class NetworkManager {
  
    static let shared = NetworkManager()
    
    func request<T: Codable>(type: T.Type, url:String, method: HTTPMethod, completion: @escaping((Result<T, ErrorTypes>)->())) {
        
        let bearerToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5MzYwMTE0MzRlODE3MzBlNGNlZjYyOWJjNDFkYmZiMyIsInN1YiI6IjY1YTI0N2JjNTY5MGI1MDEyZmFmZWY3MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Ss4tmRXVu7ww_7O1nsBpn_LJxW6ofdJwUVAmh6VvfPg"
        let headers: HTTPHeaders = ["Authorization": "Bearer \(bearerToken)"]
        AF.request(url, method: method, headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
                self.handleResponse(data: data) { response in
                    completion(response)
                }
            case .failure(_):
                completion(.failure(.generalError))
            }
        }
    }
    
    fileprivate func handleResponse<T : Codable>(data: Data, completion: @escaping((Result<T, ErrorTypes>)->())) {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            completion(.success(result))
        } catch {
            print("Error decoding JSON: \(error)")
            completion(.failure(.invalidData))
        }
    }
}


