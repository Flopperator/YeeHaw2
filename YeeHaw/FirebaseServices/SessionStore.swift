

import Foundation
import Combine
import Firebase
import FirebaseAuth

class SessionStore: ObservableObject {
    
    var didChange = PassthroughSubject<SessionStore, Never>() //basically if you subscribe then you will get all the published events
    @Published var session: User? {didSet{self.didChange.send(self)}}
    var handle: AuthStateDidChangeListenerHandle?
    
    
    
    //When you call listen firebase will look for the changes
    func listen(){
        handle = Auth.auth().addStateDidChangeListener({
            (auth,user) in
            if let user = user{
                let firestoreUserId = AuthService.getUserId(userId: user.uid)
                firestoreUserId.getDocument{
                    (document, error) in
                    if let dict = document?.data(){
                        guard let  decodedUser = try? User.init(fromDictionary: dict) else {
                            return
                        }
                        self.session = decodedUser
                    }
                }
            }else {
                self.session = nil
            }
        })
    }
    func logOut() {
        do{
            try Auth.auth().signOut()
        }catch{
            
        }
    }
    func unbind() {
        if let handle = handle{
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    deinit {
        unbind()
    }
}
