//
//  WebHelper.swift
//  LogitechChallenge
//
//  Created by Anurag on 21/12/18.
//  Copyright © 2018 Anurag. All rights reserved.
//

import UIKit

typealias ResultCompletion = ([Movie?]) -> ()

protocol WebServiceProtocol {
    func callApi(completion: @escaping ResultCompletion)
}

final class WebHelper: WebServiceProtocol {
    
    // To ensure creation of single instance :: No need to use singleton here
//    fileprivate init() {}
//    static let sharedInstance = WebHelper()
    
    
    private func get(_ request: URLRequest, completion: @escaping (_ success: Bool, _ data: Data?) -> ()) {
        dataTask(request, method: "GET", completion: completion)
    }
    
    private func dataTask(_ req: URLRequest, method: String, completion: @escaping (_ success: Bool, _ data: Data?) -> ()) {
        var request = req
        request.httpMethod = method
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        session.dataTask(with: request) { (data, response, error) -> Void in
            if let data = data {
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    completion(true, data)
                } else {
                    completion(false, data)
                }
            }
        }.resume()
    }
    
    private func clientURLRequest(_ path: String) -> URLRequest {
        var request = URLRequest(url: URL(string: path)!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        return request
    }

    
    func callApi(completion: @escaping ResultCompletion) {
        let requestURL = Constants.URL.apiURL
        
        get(clientURLRequest(requestURL)) { (success, object) -> () in
            DispatchQueue.main.async {
                if success {
                    if let data = object {
                        let decoder = JSONDecoder()
                        let movies = try! decoder.decode(MovieArray.self, from: data)
                        completion(movies.movie)
                        return
                    }
                } else {
                    print("Oops! Something went wrong..")
                }
                completion([])
            }
        }
    }

}
