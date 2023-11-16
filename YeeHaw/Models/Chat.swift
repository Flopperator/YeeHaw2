import Foundation
import Firebase

struct Chat: Encodable, Decodable, Hashable {
    var messgeId: String
    var textMessgae: String
    var profile: String
    var photoUrl: String
    var sender: String
    var username: String
    var timestamp: Double
    var isCurrentUser: Bool{
        return Auth.auth().currentUser!.uid == sender
    }
    var isPhoto: Bool
    
    
    
    
}

