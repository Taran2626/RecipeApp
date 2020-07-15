//
//  APIManager.swift
//  Recipe App
//
//  Created by Taran  on 03/07/20.
//  Copyright © 2020 Macbook_Taranjeet. All rights reserved.
//


import Foundation
import UIKit

// MARK: - APIManager
class APIManager {
    static let shared = APIManager()
    private lazy var httpClient : HTTPClient = HTTPClient()
    
    func request(with api : Router , completion : @escaping (Result<Any?,Error>) -> ())  {
        httpClient.postRequest(withApi: api) { (response) in
            switch response {
            case .success(let data) :
                let object = api.handle(data: data)
                completion(.success(object))
            case .failure(let error) :
                completion(.failure(error))
            }
        }
    }
}
