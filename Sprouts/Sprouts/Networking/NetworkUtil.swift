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
            var getURL = ""
            getURL.append(baseURLString)
            getURL.append("species/")
            getURL.append(query)
            getURL.append("?token=")
            getURL.append(token)
            
            let returnURL = URL(string: getURL)
            return returnURL
        }
        
        return nil
    }
}

enum RequestType {
    case searchPlants
    case getFromID
    
}
