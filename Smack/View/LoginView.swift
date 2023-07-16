//
//  LoginView.swift
//  Smack
//
//  Created by HardiB.Salih on 7/15/23.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var modalManager: ModalManager
    @EnvironmentObject var userViewModel : UserViewModel

    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack(alignment: .center, spacing: 20.0) {
            HStack(alignment: .center, spacing: 8.0) {
                Image(AssetsIcon.smackLogo.rawValue)
                
                Text("Smack").font(.title).fontWeight(.bold)
                    .foregroundColor(Color(AssetsColor.firstColor.rawValue))
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
            
            VStack {
                Button {
                    userViewModel.signIn(email: email, password: password) { success , error in
                        if success {
                            print("User signed in successfully")
                            // Continue with the signed-in user's logic
                            modalManager.showModal.toggle()
                            
                        } else {
                            print("Sign-in failed with error: \(error?.localizedDescription ?? "")")
                            // Handle the sign-in failure
                        }
                        
                    }
                    
                    
                    
                    
                } label: {
                    Text("Login")
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
                HStack(alignment: .center, spacing: 5.0){
                    Text("Don't have an account?").font(.footnote).bold()
                    Button{
                        withAnimation {
                            modalManager.activeModal = .signUp
                        }
                    } label: {
                        Text("Sign up here").font(.footnote).bold().foregroundColor(Color(AssetsColor.secondColor.rawValue))
                    }
                }
            }
            Spacer()
            
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(ModalManager())
            .environmentObject(UserViewModel())
    }
}
