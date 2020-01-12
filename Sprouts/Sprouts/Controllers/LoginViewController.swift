//
//  LoginViewController.swift
//  Sprouts
//
//  Created by Wren Liang on 2020-01-11.
//  Copyright © 2020 Alan Yan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    var newView: LoginView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newView = LoginView()
        
        newView.loginButton.addTarget(self, action: #selector(sendLoginOverAPI), for: .touchUpInside)
        
        self.view = newView
    }
    
    @objc func sendLoginOverAPI() {
        
        guard let andrewURL = URL(string: "http://3.19.26.69:8000/api/users"), let email = newView.emailBar.text, let password = newView.passwordBar.text else { return  }
        
        var postRequest = URLRequest(url: andrewURL)
        postRequest.httpMethod = "POST"
        postRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonBody = createJSONObj(email: email, password: password)
        
        
        postRequest.httpBody = jsonBody
        
        print("\(String(bytes: jsonBody!, encoding: .utf8))")

        
        let dataTask = URLSession.shared.dataTask(with: postRequest) {
            (data, response, error) in
            if let error = error {
                print("in error")
                print(error)
            } else if let response = response {
                print("in response")
                print(response)
            }
            
            if let data = data {
                print("in data")
//                let decodeData = try? JSONDecoder().decode(<#T##type: Decodable.Protocol##Decodable.Protocol#>, from: data)
            }
        }
        dataTask.resume()
    }
    
    func createJSONObj(email: String, password: String) -> Data? {
        struct loginJSON: Codable {
            var username: String
            var password: String
            var requestType: String
        }
        
        let myJSON = loginJSON(username: email, password: password, requestType: "login")
        
        let packagedJSON = try? JSONEncoder().encode(myJSON)
        
        guard let json = packagedJSON else {
            return nil
        }
        
        print(json)
        
        return json
    }
    
}

