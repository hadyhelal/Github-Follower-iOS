//
//  Followers.swift
//  Mini GitHub
//
//  Created by Hady on 11/7/20.
//  Copyright © 2020 HadyOrg. All rights reserved.
//

import Foundation

struct Follower : Codable , Hashable {
    var login : String
    var avatarUrl : String
    
//    func hash(into hasher : inout Hasher){
//        Hasher.combine(self.login)
//    }
}
