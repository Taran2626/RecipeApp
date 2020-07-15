//
//  HTTPClient.swift
//  Recipe App
//
//  Created by Taran  on 03/07/20.
//  Copyright © 2020 Macbook_Taranjeet. All rights reserved.
//

import Foundation

protocol HTTPClientProtocol {
    func postRequest(withApi api : Router , completion : @escaping (Result<Data,Error>) -> ())
}

// MARK: - HTTPClient
class HTTPClient : HTTPClientProtocol {
    
    var baseURL: String{
        return APIConstants.Basepath.Development
    }
    
    // this function is used to get the result from api that further pass to api handler to parse the data
    func postRequest(withApi api : Router , completion : @escaping (Result<Data,Error>) -> ()){
        let fullPath = baseURL + api.route
        let dict = api.parameters ?? [:]
        guard let url = URL(string: fullPath) else {return}
        var request = URLRequest(url: url)
        if(api.method == .get) {
            guard var components = URLComponents(string: fullPath)else { return }
            components.queryItems = dict.map { (arg) -> URLQueryItem in
                let (key, value) = arg
                return URLQueryItem(name: key, value: (value as? String) ?? "")
            }
            components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
            guard let url = components.url else{return}
            request = URLRequest(url: url)
        }else {
            let jsonData = try? JSONSerialization.data(withJSONObject: dict)
            request = URLRequest(url: url)
            request.httpMethod = api.method.rawValue
            request.httpBody = jsonData
            request.allHTTPHeaderFields = ["content-type": "application/json"]
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,                            // is there data
                let response = response as? HTTPURLResponse,  // is there HTTP response
                (200 ..< 300) ~= response.statusCode,         // is statusCode 2XX
                error == nil else {                           // was there no error, otherwise ...
                    if let errorTemp = error {
                        completion(.failure(errorTemp))
                    }
                    completion(.failure(MyError.runtimeError("server error")))
                    return
            }
            completion(.success(data))
        }
        task.resume()
    }
}


