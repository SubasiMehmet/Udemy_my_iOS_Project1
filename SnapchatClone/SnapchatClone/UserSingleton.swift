//
//  UserSingleton.swift
//  SnapchatClone
//
//  Created by Mehmet Subaşı on 22.04.2022.
//

import Foundation

class UserSingleton {
    
    static let sharedUserInfo = UserSingleton()
    
    var email = ""
    var userName = ""
    
    private init() {
        
    }
    
    
}
