

import Foundation

struct User: Encodable, Decodable{
    var uid: String
    var email: String
    var profileImageUrl: String
    var username: String
    var searchName: [String] //have to put chars of name into an array to help search efficiency
    var bio: String
    
}
