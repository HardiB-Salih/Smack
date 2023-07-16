//
//  ProfileModal.swift
//  Smack
//
//  Created by HardiB.Salih on 7/15/23.
//

import SwiftUI

struct ProfileModal: View {
    @EnvironmentObject var modalManager: ModalManager

    var body: some View {
        ZStack {
            
            Color.black.opacity(0.5)
                .onTapGesture {
                    withAnimation {
                        modalManager.showModal.toggle()
                    }
                }
                .ignoresSafeArea()
            
            
            VStack (alignment: .center, spacing: 30){
                Text("Your Profile")
                    .font(.title).fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color(AssetsColor.firstColor.rawValue))

                
                Image(AssetsIcon.profileDefault.rawValue)
                    .resizable()
                    .frame(width: 70, height: 70)
                
                VStack(spacing: 8){
                    Text("Hardi")
                        .font(.headline.bold())
                        .foregroundColor(Color(AssetsColor.firstColor.rawValue))
                    Text("Hardi@gmail.com")
                        .font(.subheadline.bold())
                        .foregroundColor(Color(AssetsColor.firstColor.rawValue))
                }
                
                Button {
                    // LogOut and Dissmiss
                } label: {
                    Text("Logout").font(.title3.bold())
                        .foregroundColor(Color(AssetsColor.firstColor.rawValue))
                }

            }
            .padding(40)
            .background(.white)
            .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay(content: {
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
                    
            })
            .padding(20)
            
                
            
        }
    }
}

struct ProfileModal_Previews: PreviewProvider {
    static var previews: some View {
        ProfileModal()
            .environmentObject(ModalManager())
    }
}
