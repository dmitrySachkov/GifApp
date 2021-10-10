//
//  NetworkApi.swift
//  Get Gif App
//
//  Created by Dmitry Sachkov on 10.10.2021.
//

import Foundation

class NetworkApi {
    static let shared = NetworkApi()
    private var dataTask: URLSessionDataTask?
    
    //MARK: - Get albums data
    func fetchGif(url: String, completion: @escaping (Result<GifsData, Error>) -> Void) {
        guard let urlString = URL(string: url) else { return}
        
        //MARK: - URLSession
        dataTask = URLSession.shared.dataTask(with: urlString) { (data, response, error) in
            
           //Handle Error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            guard let response  = response as? HTTPURLResponse else {
                //Handle Error
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            guard let data = data else {
                print("Empty Data")
                return
            }
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(GifsData.self, from: data)
               //Back to the main thread
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            }
            catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
    
}
