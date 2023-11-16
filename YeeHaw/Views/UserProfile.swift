import SwiftUI
import SDWebImageSwiftUI

struct UserProfile: View {
    @State private var value: String = ""
    @State var users: [User] = []
    @State var isLoading = false
    
    func searchUsers(){
        isLoading = true
        
        SearchService.searchUser(input: value){
            (users) in
            self.isLoading = false
            self.users = users
        }
    }
    
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                SearchBar(value: $value).padding()
                    .onChange(of: value, perform:{
                        new in
                        searchUsers()
                    })
                if !isLoading{
                    ForEach(users, id:\.uid){
                        user in
                        
                        NavigationLink(destination: UsersProfileView(user: user)){
                            
                            
                            HStack{
                                WebImage(url: URL(string:
                                                    user.profileImageUrl)!)
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .frame(width: 100, height: 100, alignment: .trailing)
                                .padding()
                                
                                Text(user.username).font(.largeTitle).bold()
                            }
                            
                        }
                        
                    }
                    
                }
            }.navigationTitle("User Search")
        }
    }
    
}
