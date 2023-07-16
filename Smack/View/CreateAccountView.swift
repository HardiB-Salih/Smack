//
//  CreateAccountView.swift
//  Smack
//
//  Created by HardiB.Salih on 7/16/23.
//

import SwiftUI

struct CreateAccountView: View {
    @EnvironmentObject var modalManager: ModalManager
    @EnvironmentObject var userViewModel : UserViewModel

    @State var showAvatarPicker = false

    @State var username = ""
    @State var email = ""
    @State var password = ""
    @State var avatarSelected = AssetsIcon.profileDefault.rawValue
    @State var avatarColor = ""
    
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 20.0) {
            HStack(alignment: .center, spacing: 8.0) {
                Image(AssetsIcon.smackLogo.rawValue)
                
                Text("Smack").font(.title).fontWeight(.bold)
                    .foregroundColor(Color(AssetsColor.firstColor.rawValue))
            }
            
            VStack {
                TextField("User name", text: $username)
                RoundedRectangle(cornerRadius: 2, style: .continuous)
                    .fill(Color(AssetsColor.firstColor.rawValue).opacity(0.6))
                    .frame(height: 2)
            }
            
            VStack {
                TextField("Email", text: $email)
                RoundedRectangle(cornerRadius: 2, style: .continuous)
                    .fill(Color(AssetsColor.firstColor.rawValue).opacity(0.6))
                    .frame(height: 2)
            }
            
            VStack {
                SecureField("Password", text: $password)
                RoundedRectangle(cornerRadius: 2, style: .continuous)
                    .fill(Color(AssetsColor.firstColor.rawValue).opacity(0.6))
                    .frame(height: 2)
            }
            
            VStack(alignment: .center, spacing: 10.0) {
                Circle()
                    .fill(avatarColor.isEmpty ? .clear : Color(hex: avatarColor))
                    .frame(width: 80, height: 80, alignment: .center)
                    .overlay(
                        Image(avatarSelected)
                            .resizable()
                            .frame(width: 70, height: 70)
                            .foregroundColor(.blue)
                    )
                Button {
                    withAnimation {
                        showAvatarPicker.toggle()
                    }
                } label: {
                    Text("Choose avatar")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor((Color(AssetsColor.secondColor.rawValue)))
                }.sheet(isPresented: $showAvatarPicker) {
                    AvatarPickerView(avatarSelected: $avatarSelected)
                }
                
                Button {
                    withAnimation {
                        avatarColor =  helperClass.randomHexColor(isLight: avatarSelected.contains("dark"))
                    }
                } label: {
                    Text("Generate background color")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor((Color(AssetsColor.secondColor.rawValue)))
                }
            }
           
            Spacer()
            
            Button {
                userViewModel.createUser(email: email, password: password ) { success, uid, error in
                    if success {
                        // Continue with the created user's logic
                        if let uid = uid {
                            print("User created successfully with UID: \(uid)")
                            let user = User(id: uid, avatarColor: avatarColor, avatarName: avatarSelected, email: email, name: username)
                            userViewModel.createUserInFirestore(user: user) { success, error in
                                if success {
                                    modalManager.showModal.toggle()
                                } else {
                                    print("User creation in Firestore failed with error: \(error?.localizedDescription ?? "")")
                                    // Handle the user creation failure in Firestore
                                }
                            }
                        }
                    } else {
                        print("User creation failed with error: \(error?.localizedDescription ?? "")")
                        // Handle the user creation failure
                    }
                }
                
            } label: {
                Text("Create Account")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                            .fill(Color(AssetsColor.secondColor.rawValue))
                    )
            }
            
            
        }.padding(40)
            .padding(.top, 40)
            .overlay {
                Button{
                    withAnimation {
                        modalManager.showModal.toggle()
                    }
                } label: {
                    Image(AssetsIcon.closeButton.rawValue)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding()
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
            .environmentObject(ModalManager())
            .environmentObject(UserViewModel())
    }
}
