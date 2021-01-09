//
//  ErrorMessage.swift
//  Mini GitHub
//
//  Created by Hady on 11/19/20.
//  Copyright © 2020 HadyOrg. All rights reserved.
//

import Foundation

enum GFerror : String , Error{
    case invalidUsername  = "This user name created as invalid request please try again!"
    case unableToComplete = "Please check your internet connection!"
    case invalidResponse  = "Invalid response from the server."
    case invalidData      = "inValid Data From the server."
    case errorDecoding    = "Error Decoding Data!"
    
}
