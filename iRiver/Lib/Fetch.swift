import Foundation

enum APIError: Error {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case decodingError(Error)
}

struct APIManager {
    func fetch<T: Decodable>(url: URL, completion: @escaping (Result<T, APIError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data!)
                completion(.success(decodedData))
            } catch {
                if let decodingError = error as? DecodingError {
                    completion(.failure(.decodingError(decodingError)))
                } else {
                    completion(.failure(.decodingError(error)))
                }
            }
        }.resume()
    }
}
