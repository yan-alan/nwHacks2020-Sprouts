//
//  LoginResponse.swift
//  Sprouts
//
//  Created by Wren Liang on 2020-01-12.
//  Copyright © 2020 Alan Yan. All rights reserved.
//

import Foundation

struct LoginResponse: Codable {
    let message: String
    let loginSuccess: Bool
}


struct PostResponse: Codable {
    let message: String
    let plant: Plant
}


struct DeleteResponse: Codable {
    let message: String
    let plants: [Plant]
}

struct GetAllPlantsResponse: Codable {
    let plants: [Plant]
}
