

import SwiftUI
import AVFoundation


struct Post: View {
    @State private var postImage: Image?
    @State private var pickedImage: Image?
    @State private var showingActionSheet = false
    @State private var showingImagePicker = false
    @State private var imageData: Data = Data()
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var error: String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "Well Shoot..."
    @State private var text: String = ""

    
    
    func loadImage() {
        guard let inputImage = pickedImage else{
            return
        }
        postImage = inputImage
    }
    func uploadPost() {
        if let error = errorCheck() {
            self.error = error
            self.showingAlert = true
            self.clear()
            return
        }
        PostService.uploadPost(caption: text, imageData: imageData, onSuccess: {
            self.clear()
        }) 
        {
            (errorMessage) in
            self.error = errorMessage
            self.showingAlert = true
            return
        }
    }
    
    func clear(){
        self.text = ""
        self.imageData = Data()
        self.postImage = Image(systemName: "photo.fill")
    }
    
    func errorCheck()-> String?{
        if text.trimmingCharacters(in: .whitespaces).isEmpty ||
            imageData.isEmpty{
            
            return "Well pardner seems like you ain' add everything"
        }
        return nil
        
        
    }
    
    
    
    var body: some View{
        VStack(spacing: 20){
            Text("Upload A Post").font(.largeTitle).frame(alignment: .top).ignoresSafeArea(.all)
            VStack{
                if postImage != nil{
                    postImage!.resizable()
                        .frame(width: 320, height:260).onTapGesture {
                            self.showingActionSheet = true
                        }
                }else{ Image(systemName: "photo.fill").resizable()
                        .frame(width: 320, height: 260)
                        .onTapGesture {
                            self.showingActionSheet = true
                        }
                        
                    }
                }
            TextEditor(text: $text)
                .frame(height: 200)
                .padding(4)
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.secondary))
                .padding(.horizontal)
            
            Button(action: uploadPost){
                Text("Upload Post").font(.title).modifier(ButtonModifiers())
            }.alert(isPresented:$showingAlert) {
                Alert(title: Text(alertTitle),message : Text(error), dismissButton: .default(Text("Alrighty")))
            }
        }.padding()
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage){
                ImagePicker(pickedImage: self.$pickedImage, showImagePicker: self.$showingImagePicker, imageData: self.$imageData)
            }.actionSheet(isPresented: $showingActionSheet){
                ActionSheet (title: Text(""), buttons: [.default(Text("Pick Yer Picture Partner")){
                    self.sourceType = .photoLibrary
                    self.showingImagePicker = true
                },
                                                        .default(Text("Take Yer Photo")){
                                                            self.sourceType = .camera
                                                        }, .cancel()
                                                       ])
            }
        
        
        }
        
    }

