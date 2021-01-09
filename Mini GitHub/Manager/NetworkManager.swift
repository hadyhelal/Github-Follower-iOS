//
//  NetworkManager.swift
//  Mini GitHub
//
//  Created by Hady on 11/7/20.
//  Copyright © 2020 HadyOrg. All rights reserved.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    let cache = NSCache< NSString , UIImage>()
    
    private let  baseUrl = "https://api.github.com/users/"
    let perBageFollower = 100
    
    // This init to restrict it just gonna be one instance! its Singleton bro
    private init () {}
    
    func getFollower(for userName : String , page : Int , completed : @escaping (Result<[Follower] , GFerror>) -> Void)  {
        let endPoint =  baseUrl + "\(userName)/followers?per_page=\(perBageFollower)&page\(page)"
        
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error  { //check if it's not nil
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else{
                completed(.failure(.invalidData))
                return
            }
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self , from: data)
                completed(.success(followers))
            }catch{
                completed(.failure(.errorDecoding))
            }
        }
        task.resume()
    }
    
    
    
    func getUserInfo(for userName : String , completed : @escaping (Result<User, GFerror>) -> Void)  {
           let endPoint =  baseUrl + "\(userName)"
           
           guard let url = URL(string: endPoint) else {
               completed(.failure(.invalidUsername))
               return
           }
           
           let task = URLSession.shared.dataTask(with: url) { data, response, error in
               if let _ = error  { //check if it's not nil
                   completed(.failure(.unableToComplete))
                   return
               }
               
               guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                   completed(.failure(.invalidResponse))
                   return
               }
               
               guard let data = data else{
                   completed(.failure(.invalidData))
                   return
               }
               do{
                   let decoder = JSONDecoder()
                   decoder.keyDecodingStrategy = .convertFromSnakeCase
                   let user = try decoder.decode(User.self , from: data)
                   completed(.success(user))
               }catch{
                   completed(.failure(.errorDecoding))
               }
           }
           task.resume()
       }
}
