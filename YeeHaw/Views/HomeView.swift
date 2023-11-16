
import SwiftUI



struct HomeView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var username: String = ""
    @State private var profileImage: Image?
    @State private var pickedImage: Image?
    @State private var showingActionSheet = false
    @State private var showingImagePicker = false
    @State private var imageData: Data = Data()
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var error: String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "Well Shoot..."
    
    
    var body: some View {
        
        
        
        VStack{
            CustomTabView()
            
        }
    }
}

var tabs = ["house.fill", "magnifyingglass","plus.app","person.fill"]

struct CustomTabView: View{
    @State var selectedTab = "house.fill"
    @State var edge = UIApplication.shared.windows.first?.safeAreaInsets
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal:.center, vertical: .bottom)){
            
            NavigationView{ //maybe take out?
                TabView(selection: $selectedTab) {
                    Main()
                        .tag("house.fill")
                    UserProfile()
                        .tag("magnifyingglass")
                    Post()
                        .tag("plus.app")
                    Profile()
                        .tag("person.fill")
                    
                }
            }.accentColor(.color0)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .ignoresSafeArea(.all,edges: .bottom)
            
            HStack(spacing: 0) {
                ForEach(tabs, id: \.self){
                    image in
                    TabButton(image: image, selectedTab: $selectedTab)
                    
                    if image != tabs.last{
                        Spacer(minLength: 0)
                        
                    }
                }
            }.padding(.horizontal, 20)
                .padding(.vertical, 3)
                .background(Color.black)
                .clipShape(Capsule())
                .shadow(color: Color.gray.opacity(0.10), radius: 10, x:10, y:10)
                .shadow(color: Color.gray.opacity(0.10), radius: 10, x:-10, y:-10)
                .padding(.horizontal)
                .padding(.bottom, edge!.bottom == 0 ? 10: 0)
            
            
        }.ignoresSafeArea(.keyboard, edges:.bottom)
            .background(Color.black.opacity(0.05).ignoresSafeArea(.all, edges:.all))
    }
    
}


struct TabButton: View {
    var image: String
    
    @Binding var selectedTab: String
    
    var body: some View{
        Button(action: {selectedTab = image}){
            Image(systemName: "\(image)")
                .foregroundColor(selectedTab == image ? Color.color0: Color.secondary)
                .padding()
        }
    }
}
