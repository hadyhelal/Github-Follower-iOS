//
//  User.swift
//  Mini GitHub
//
//  Created by Hady on 11/7/20.
//  Copyright © 2020 HadyOrg. All rights reserved.
//

import Foundation

struct User : Codable {
    let login : String
    let avatarUrl : String
    var name : String?
    var location : String?
    var bio : String?
    let publicRepos: Int
    let publicGists : Int
    let htmlUrl : String
    let following : Int
    let followers : Int
    let createdAt : String
    //any non optional value could be (Let)
    
}
