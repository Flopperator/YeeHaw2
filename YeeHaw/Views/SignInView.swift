
import SwiftUI



struct SignInView: View {
    @EnvironmentObject var session: SessionStore
    
    func listen(){
        session.listen()
    }
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var error: String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "Well Shoot..."
    
    func errorCheck()-> String?{
        if email.trimmingCharacters(in: .whitespaces).isEmpty ||
            password.trimmingCharacters(in: .whitespaces).isEmpty
        {
            
            return "Well pardner seems like you ain' fill everything out"
        }
        return nil
        
        
    }
    
    func clear(){
        self.email = ""
        self.password = ""
    }
    
    func signIn(){
        if let error = errorCheck() {
            self.error = error
            self.showingAlert = true
            return
        }
        
        AuthService.signIn(email: email, password: password,
                           onSuccess:{
            (user) in
            self.clear()
        }){
            (errorMessage) in
            print("Error \(errorMessage)")
            self.error = errorMessage
            self.showingAlert = true
            return
        }
        
    }
        
        var body: some View {
            NavigationView{
                GeometryReader{ reader in
                    VStack(){
                        Spacer()
                            .background{
                                Image("Gradient")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(
                                        width: reader.size.width,
                                        height: reader.size.height-400,
                                        alignment: .top
                                    )
                                
                            }
                        Spacer()
                            .overlay{
                                Image("Logo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(
                                        width: reader.size.width,
                                        height: reader.size.height-400,
                                        alignment: .top
                                    )
                                
                            }
                        HStack(){
                            VStack(spacing: 20){
                                VStack(alignment: .leading){
                                    Text("Git On In Here!").font(.system(
                                        size: 32,
                                        weight: .heavy))
                                }
                                VStack(alignment: .leading){
                                    Text("Imma Need That There Sign-In Info To Proceed").font(.system(
                                        size: 16,
                                        weight: .medium))
                                }
                                
                                FormField(value: $email,
                                          icon: "envelope.fill",
                                          placeholder: "E-mail/Username",
                                          isSecure: false)
                                FormField(value: $password,
                                          icon: "lock.fill",
                                          placeholder: "Password",
                                          isSecure: true)
                                
                                Button(action: {signIn()
                                    listen()
                                    
                                    
                                }){
                                    Text("Sign In").font(.title)
                                        .modifier(ButtonModifiers())
                                }.alert(isPresented:$showingAlert) {
                                    Alert(title: Text(alertTitle),message : Text(error), dismissButton: .default(Text("Alrighty")))
                                }
                                
                                NavigationLink(destination: SignUpView()){
                                    HStack{
                                        Text("New Cowpoke?").foregroundColor(.secondary)
                                        
                                        Text("Create an Account.").foregroundColor(.secondary)
                                    }
                                    
                                }
                                
                            }.padding()
                        }.padding(.init(top: 0, leading: 0, bottom: 100, trailing: 0))
                    }.edgesIgnoringSafeArea(.top)
                    
                }
            }
            
            
        }
        
    }

