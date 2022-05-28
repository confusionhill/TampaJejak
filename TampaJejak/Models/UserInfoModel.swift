//
//  UserInfoModel.swift
//  TampaJejak
//
//  Created by Farhandika on 26/05/22.
//

import Foundation
import Firebase

public enum Gender: String, CaseIterable {
    case none = ""
    case male = "Male"
    case female = "Female"
    case genderFluid = "Gender Fluid"
}

struct UserInfoModel {
    var user: User
    var main: MainUserModel
}

struct SignUpUserModel {
    var email: String
    var password: String
    var main: MainUserModel
}

struct MainUserModel {
    var fullName: String
    var phoneNumber: String
    var gender: Gender
    var userName: String
}
