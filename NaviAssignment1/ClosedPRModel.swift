//
//  ClosedPRModel.swift
//  NaviAssignment1
//
//  Created by Nancy Jain on 30/07/22.
//

import Foundation

//struct ClosedPRModel: Decodable {
//    var userDetails: UserDetails
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        userDetails = try container.decode(UserDetails.self)
//      }
//}

struct UserDetails: Decodable {
    var title: String
    var created_at: String
    var closed_at: String
    var user: User
//    enum Keys: String, CodingKey {
//        case title
//        case created_at
//        case closed_at
//        case user
//      }
//
//      init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: Keys.self)
//        title = try container.decode(String.self, forKey: .title)
//        created_at = try container.decode(String.self, forKey: .created_at)
//        closed_at = try container.decode(String.self, forKey: .closed_at)
//        user = try container.decode([User].self, forKey: .user)
//      }
}

struct User: Decodable {
    var login: String
    var avatar_url: String
//    enum Keys: String, CodingKey {
//        case login
//        case avatar_url
//    }
//
//    init(from decoder: Decoder) throws {
//      let container = try decoder.container(keyedBy: Keys.self)
//      login = try container.decode(String.self, forKey: .login)
//      avatar_url = try container.decode(String.self, forKey: .avatar_url)
//    }
    
}
