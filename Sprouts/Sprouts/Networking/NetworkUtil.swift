//
//  NetworkUtil.swift
//  Sprouts
//
//  Created by Wren Liang on 2020-01-11.
//  Copyright © 2020 Alan Yan. All rights reserved.
//

import Foundation

class NetworkUtil {
    static let baseURLString = "https://trefle.io/api/"
    static let token = "SlhiL0ZYc29jZGpmQmhoY0QzUzNkdz09"
    
    static func callAPI(queryPhrase: String, requestType: RequestType) {
        
        let url = makeURL(query: queryPhrase, request: requestType)
        
        if let apiURL = url {
            let dataTask = URLSession.shared.dataTask(with: apiURL) {
                (data, response, error) in
                if let error = error {
                    print(error)
                } else if let inData = data {
                    let decodeData = try? JSONDecoder().decode(SearchResults.self, from: inData)
                    
                    DispatchQueue.main.async {
                        //completion handler
                        print(decodeData)
                        
                    }
                }
            }
            
            dataTask.resume()
        }
        
    }
    
    static func makeURL(query: String, request: RequestType) -> URL? {
        
        if (request == RequestType.searchPlants) {
            var searchURL = ""
            searchURL.append(baseURLString)
            searchURL.append("plants?=")
            searchURL.append(query)
            searchURL.append("&token=")
            searchURL.append(token)
            
            let returnURL = URL(string: searchURL)
            return returnURL
        } else if (request == RequestType.getFromID){
            //handle this request
        }
        
        return nil
    }
}

enum RequestType {
    case searchPlants
    case getFromID
    
}
