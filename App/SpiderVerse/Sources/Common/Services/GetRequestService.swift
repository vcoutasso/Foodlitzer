import Foundation

enum RequestError: Error {
    case invalidURL
    case decodingError
    case statusNotOK
    case noResponse
    case noData
}

protocol GetRequestServiceProtocol {
    var baseURL: URL { get }
    func addQueryItem(name: String, value: String)
}

class GetRequestService<T>: GetRequestServiceProtocol where T: Decodable {
    // MARK: - Properties

    let baseURL: URL

    var urlComponents: NSURLComponents?

    // MARK: - Dependencies

    let decoder: JSONDecoding

    // MARK: - Object lifecycle

    init(from baseURL: URL, with decoder: JSONDecoding) {
        self.baseURL = baseURL
        self.decoder = decoder
    }

    init?(from link: String, with decoder: JSONDecoding) {
        guard let url = URL(string: link) else { return nil }

        self.baseURL = url
        self.decoder = decoder
    }

    // MARK: - Request methods

    func addQueryItem(name: String, value: String) {
        createURLComponents()

        let queryItem = URLQueryItem(name: name, value: value)

        urlComponents!.queryItems?.append(queryItem)
    }

    func makeRequest() async -> Result<T, RequestError> {
        guard let requestURL = urlComponents?.url?.absoluteURL else { return .failure(.invalidURL) }

        let request = URLRequest(url: requestURL)

        let result = await withCheckedContinuation { continuation in
            fetchData(from: request) { continuation.resume(returning: $0) }
        }

        resetURLComponents()

        return result
    }

    // MARK: - Helper methods

    // TODO:
    private func fetchData(from request: URLRequest, completion: @escaping (Result<T, RequestError>) -> Void) {
        URLSession.shared.dataTask(with: request) { [weak self] data, urlResponse, error in
            guard let self = self else { return }
            if let error = error {
                debugPrint("Request error: \(error.localizedDescription)")
            }

            guard let urlResponse = urlResponse as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            if urlResponse.statusCode != 200 {
                completion(.failure(.statusNotOK))
                return
            }

            guard let decodedData = try? self.decoder.decode(T.self, from: data) else {
                print(String(decoding: data, as: UTF8.self))
                completion(.failure(.decodingError))
                return
            }

            completion(.success(decodedData))
        }.resume()
    }

    private func createURLComponents() {
        guard urlComponents == nil else { return }

        urlComponents = NSURLComponents(string: baseURL.absoluteString)
        urlComponents?.queryItems = []
    }

    private func resetURLComponents() {
        urlComponents = nil
    }
}
