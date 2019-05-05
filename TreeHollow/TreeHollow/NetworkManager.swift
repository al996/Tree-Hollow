//
//  NetworkManager.swift
//  TreeHollow
//
//  Created by Rachel Deng on 5/3/19.
//  Copyright © 2019 Rachel Deng. All rights reserved.
//

import Foundation
import Alamofire

struct Response<T: Codable>: Codable {
    var success: Bool
    var data: T
}

struct GetUser: Codable {
    var id: Int
    var nickname: String
    var joined: Double
}

struct GetPosts: Codable {
    var id: String
    var text: String
    var nickname: String
    var uploaded: Double
}

class NetworkManager {
    static let url = "http://34.74.247.147/api/"
//    static let userurl = URL(string: "users/")
//    static let getPostsUrl = URL(string: "http://34.74.247.147/api/posts/")
    static let getUserUrl = "http://34.74.247.147/api/users/\(AppDelegate.usertoken!)/"
    
    static func performPostRequest(url: URL, jsonDataArray: [String : Any], errorAction: String, completionHandler: @escaping ((_ response: [String : Any]?) -> Void)) {
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonDataArray, options: .prettyPrinted)
            urlRequest.httpBody = jsonData

        } catch let error {
            print("Error \(errorAction): \(error)")
        }

        let requestTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error \(errorAction): \(error!)")
                return
            }

            do {
                let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                completionHandler(jsonData)

            } catch let error {
                print("Error \(errorAction): \(error)")
            }
        }

        requestTask.resume()
    }
    
    

    
    

    
    static func postSecrets(text: String, token: String){
        performPostRequest(url: URL(string: "\(url)posts/")!, jsonDataArray: ["text": text, "token": token], errorAction: "") { (result) in
            print("result is \(result)")
        }
    }
//
//    static func getPosts(){
//        performGetRequest(url: URL(string: "\(url)posts/")!, errorAction: "") { (data) in
//            if let data = data {
//                let jsonDecoder = JSONDecoder()
//                if let response = try? jsonDecoder.decode(Response<GetPosts>.self, from: data){
//                        print("getPosts returns \(response.data.text)")
//                    }
//
//                }else{
//                    print("Invalid response data")
//                }
//            }
//        }
 
    static func getUser(completion: @escaping (_ response: Bool) -> Void) {
        print("getUser func Usertoken is \(AppDelegate.usertoken!)")
        Alamofire.request(NetworkManager.getUserUrl, method: .get, encoding: URLEncoding.default).responseData { (response) in
            switch response.result{
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let response = try? jsonDecoder.decode(Response<GetUser>.self, from: data){
                    print("getUser returns \(response.success)")
                    completion(response.success)
                }else{
                    print("Invalid response data")
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
    
    static func registerUser(nickname: String, usertoken: String) -> Void {
        let registerURL = "\(url)users/"
        let parameters: Parameters = [
            "nickname": nickname,
            "token": usertoken
        ]
        Alamofire.request(registerURL, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { (response) in
            switch response.result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }

    }
   
}

    




