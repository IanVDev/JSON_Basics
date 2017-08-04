//
//  ViewController.swift
//  JSON
//
//  Created by Ian Vilhena on 8/3/17.
//  Copyright © 2017 Ian Vilhena. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let BASE_URL = "https://jsonplaceholder.typicode.com"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getButtonTapped(_ sender: UIButton) {
        
        guard let url = URL(string: BASE_URL + "/users") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                print(data)
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options:[])
                    print(json)
                }catch{
                    print(error)
                }
            }
        }.resume()
    }
    
    @IBAction func postButtonTapped(_ sender: UIButton) {
        
        let parameters = ["username": "@ian_zitoo", "tweet": "code passionately"]
        
        guard let url = URL(string: BASE_URL + "/posts") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
            
            }.resume()

    }
    

    
    
    
}


