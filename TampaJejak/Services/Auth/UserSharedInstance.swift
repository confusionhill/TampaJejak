//
//  UserSharedInstance.swift
//  TampaJejak
//
//  Created by Farhandika on 14/05/22.
//

import Foundation

final class UserSharedInstance {
    public static let shared = UserSharedInstance()
    
    public var userState: Bool {
        return true
    }
}
