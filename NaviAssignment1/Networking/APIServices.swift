//
//  APIServices.swift
//  NaviAssignment1
//
//  Created by Nancy Jain on 30/07/22.
//

import Foundation

class ApiServices {
    private var urlSessionDataTask: URLSessionDataTask?
    var isPaginating: Bool = false
    func getData(pagination: Bool = false, completion: @escaping (Result<[UserDetails], Error>) -> Void) {
        if pagination {
            isPaginating = true
        }
        let closedPullRequestsURL = "https://api.github.com/repos/manticoresoftware/manticoresearch/pulls?state=closed"
        guard let url = URL(string: closedPullRequestsURL) else { return }

        urlSessionDataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in

            // Handle error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }

            guard let response = response as? HTTPURLResponse else {
                // Handle empty response
                print("Empty response")
                return
            }
            print("Response status code: \(response.statusCode)")

            guard let data = data else {
                // Handle empty data
                print("Empty data")
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let jsonData = try jsonDecoder.decode([UserDetails].self, from: data)

                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error{
                completion(.failure(error))
            }
            if pagination {
                self.isPaginating = false
            }
        }
        urlSessionDataTask?.resume()

    }
}
