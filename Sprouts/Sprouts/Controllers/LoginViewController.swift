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
        let newView = LoginView()
        
        newView.loginButton.addTarget(self, action: #selector(sendLoginOverAPI), for: .touchUpInside)
        
        self.view = newView
    }
    
    @objc func sendLoginOverAPI() {
        guard let andrewURL = URL(string: "http://3.19.26.69:8000/api/users"), let email = newView.emailBar.text, let password = newView.passwordBar.text else { return  }
        
        var postRequest = URLRequest(url: andrewURL)
        postRequest.httpMethod = "POST"
        
        let jsonBody = createJSONObj(email: email, password: password)
        
        postRequest.httpBody = jsonBody
        
        let dataTask = URLSession.shared.dataTask(with: postRequest) {
            (data, response, error) in
            //handle shit
        }
        dataTask.resume()
    }
    
    func createJSONObj(email: String, password: String) -> Data? {
        let jsonObj = ["email": email, "password": password]
        let serializedJSON = try? JSONSerialization.data(withJSONObject: jsonObj)
        
        return serializedJSON
    }
    
}

