
import SwiftUI
import FirebaseAuth
import SDWebImageSwiftUI


struct Profile: View {
    @EnvironmentObject var session: SessionStore
    @State private var selection = 1
    @StateObject var profileService = ProfileService()
    @State private var isLinkActive = false
    let threeColumns = [GridItem(), GridItem(), GridItem()]
    
    var body: some View {
        ScrollView{
            VStack{
                
                ProfileHeader(user: self.session.session, postsCount: profileService.posts.count, following: $profileService.following, followers: $profileService.followers)
                VStack(alignment: .leading){
                    Text(session.session?.bio ?? "").font(.headline).lineLimit(1)
                }
                NavigationLink(destination: EditProfile(session: self.session.session), isActive: $isLinkActive){
                    Button(action: {self.isLinkActive = true}){
                        Text("Edit Profile").font(.title)
                            .modifier(ButtonModifiers0())
                        
                    }.padding(.horizontal)
                }
                    Picker("",selection: $selection){
                        Image(systemName: "circle.grid.2x2.fill").tag(0)
                        Image(systemName: "person.circle").tag(1)
                    }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal)
                    
                    if selection == 0 {
                        LazyVGrid(columns: threeColumns){
                            ForEach(self.profileService.posts, id: \.postId){
                                (post) in
                                
                                WebImage(url: URL(string: post.mediaUrl)!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.height/4).clipped()
                            }
                        }
                    }
                    else if(self.session.session == nil){
                        Text("")
                    }else{
                        ScrollView{
                            VStack{
                                ForEach(self.profileService.posts, id:\.postId){
                                    (post) in
                                    
                                    PostCardImage(post: post)
                                    PostCard(post: post)
                                }
                            }
                            
                        }
                        
                        
                    }
                    
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {}){
                NavigationLink(destination: UserProfile()){
                    Image(systemName:"person")
                }
            }, trailing: Button(action: {self.session.logOut()}){
                Image(systemName:"arrow.right.circle.fill")
            })
            .onAppear{
                self.profileService.loadUserPosts(userId:
                                                    Auth.auth().currentUser!.uid)
                
            }
            
        }
    }
