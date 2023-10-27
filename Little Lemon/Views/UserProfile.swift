//
//  UserProfile.swift
//  Little Lemon
//
//  Created by Bruce Burgess on 10/23/23.
//

import SwiftUI

struct UserProfile: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var appState: AppState
    
    @Binding var profileImage : Image? //= loadImageFromDocumentDirectory() ?? Image(systemName: "person.circle")
    @State private var backupImage: Image?
    let imageHeight : CGFloat = 100
    let imageWidth : CGFloat = 100
    
    // Create constants to hold user information from UserDefaults
    @State var firstName: String = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    @State var lastName: String = UserDefaults.standard.string(forKey: kLastName) ?? ""
    @State var email: String = UserDefaults.standard.string(forKey: kEmail) ?? ""
    
    @State private var isImagePickerPresented = false
    
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentCamera = false
    @State private var isImagePickerLoaded = false
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                Text("Personal Information")
                    .padding()
                    .fontWeight(.semibold)
                    .font(.largeTitle)
                    .foregroundStyle(Color.primary2)
                
                HStack {
                    VStack {
                        Text("Avatar")
                            .font(.caption)
                            .foregroundStyle(Color.secondary3)
                        profileImage?
                            .resizable()
                            .frame(width: imageWidth, height: imageHeight)
                            .clipShape(Circle())
                            .padding(.bottom, 20)
                    }
                    .padding(.horizontal, 20)
                    
                    Button("Change Avatar") {
                        isImagePickerPresented = true
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 10)
                    .background(Color.primary2)
                    .tint(Color.secondary4)
                    .cornerRadius(8)
                    
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color.primary1)
            
            VStack(alignment: .leading, spacing: 8){
                Text("First Name")
                TextField("First Name", text: $firstName)
                      .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 20)
            
            VStack(alignment: .leading, spacing: 8){
                Text("Last Name")
                TextField("First Name", text: $lastName)
                      .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 20)
            
            VStack(alignment: .leading, spacing: 8){
                Text("Email")
                TextField("First Name", text: $email)
                      .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 20)
        }
        
       
        
        VStack{
            Button("Save Changes") {
                UserDefaults.standard.set(firstName, forKey: kFirstName)
                UserDefaults.standard.set(lastName, forKey: kLastName)
                UserDefaults.standard.set(email, forKey: kEmail)
                saveImageToDocumentDirectory(image: profileImage, width: imageWidth, height: imageHeight)
                backupImage = profileImage
                self.presentation.wrappedValue.dismiss()
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 100)
            .background(Color.primary1)
            .tint(Color.secondary3)
            .cornerRadius(8)
            
            Spacer()
            
            Button("Logout") {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                UserDefaults.standard.set("", forKey: kFirstName)
                UserDefaults.standard.set("", forKey: kLastName)
                UserDefaults.standard.set("", forKey: kEmail)
                saveImageToDocumentDirectory(image: nil, width: 0, height: 0)
                appState.isLoggedIn = false
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 150)
            .background(Color.primary2)
            .tint(Color.secondary4)
            .cornerRadius(8)
            .fontWeight(.bold)
            
        }
        .padding()
        
        .alert("Select a source for your profile picture", isPresented: $isImagePickerPresented) {
            Button("Camera", role: .none) {
                self.shouldPresentImagePicker = true
                self.shouldPresentCamera = true
            }
            Button("Photo Library", role: .none) {
                self.shouldPresentImagePicker = true
                self.shouldPresentCamera = false
            }
            Button("Cancel", role: .cancel) {}
        }
        
        .sheet(isPresented: $shouldPresentImagePicker) {
            if isImagePickerLoaded {
                SUImagePickerView(sourceType: self.shouldPresentCamera ? .camera : .photoLibrary, image: self.$profileImage, isPresented: self.$shouldPresentImagePicker)
            } else {
                ProgressView("Loading Image Picker...")
                      .onAppear {
                          // Delay the image picker presentation to allow the ProgressView to appear
                          DispatchQueue.main.async {
                              self.isImagePickerLoaded = true
                          }
                      }
            }
            
        }
        
        .navigationBarTitle("Profile", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Image("littleLemonLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 40)
            }
        }
        .toolbarBackground(Color.white, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        
        .onAppear {
            backupImage = profileImage
        }
        .onDisappear {
            profileImage = backupImage
        }
    }
}

#Preview {
    UserProfile(profileImage: .constant(nil))
}
