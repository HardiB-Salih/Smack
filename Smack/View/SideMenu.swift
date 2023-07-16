//
//  SideMenu.swift
//  Smack
//
//  Created by HardiB.Salih on 7/15/23.
//

import SwiftUI

struct SideMenu: View {
    @State var selectedMenu: Int = 0
    @Binding var isOpen: Bool
    @Binding var channel : Channel
    @EnvironmentObject var modalManager: ModalManager
    @EnvironmentObject var userViewModel : UserViewModel
    @EnvironmentObject var messageViewModel : MessageViewModel

    
    var body: some View {
        VStack (alignment: .leading){
            Text("Smack")
                .font(.title.bold())
            
            HStack {
                Text("CHANNELS")
                    .font(.subheadline)
                    .fontWeight(.light)
                Spacer()
                Button{
                    withAnimation {
                        modalManager.showModal.toggle()
                        modalManager.activeModal = .addChannel
                    }
                } label: {
                    Image(AssetsIcon.addChannelButton.rawValue)
                }
            }
            
            
            ScrollView {
                ForEach(Array(messageViewModel.channels.enumerated()) , id: \.offset) { index, item in
                    Text("#\(item.channelTitle)").font(.headline)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(12)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.blue)
                                .frame(maxWidth: selectedMenu == index ? .infinity : 0)
                            //This to Animate from the leading
                                .frame(maxWidth: .infinity, alignment: .leading)
                        )
                        .background(.black.opacity(0.01))
                        .onTapGesture {
                            channel = item
                            messageViewModel.retrieveMessages(channelId: item.id)
                            withAnimation(.timingCurve(0.2, 0.8, 0.2, 1)) {
                                selectedMenu = index
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                                    isOpen.toggle()
                                }
                            }
                        }
                }
            }
            
            
            Spacer()
            
            HStack (spacing: 12){
                Circle()
                    .fill(userViewModel.currentUser != nil ? Color(hex: userViewModel.currentUser!.avatarColor) : .clear)
                    .frame(width: 65, height: 65, alignment: .center)
                    .overlay(
                        Image(userViewModel.currentUser != nil ? userViewModel.currentUser!.avatarName : AssetsIcon.profileDefault.rawValue)
                            .resizable()
                            .frame(width: 60, height: 60)
                    )
                
                Text(userViewModel.currentUser != nil ? userViewModel.currentUser!.name : "Login")
                    .font(.title).bold()
                Spacer()
            }
            .padding(.horizontal, 12)
            .background(.black.opacity(0.001))
            .onTapGesture {
                if userViewModel.currentUser == nil {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                        isOpen.toggle()
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation {
                            modalManager.showModal.toggle()
                            modalManager.activeModal = .signIn
                        }
                    }
                } else {
                    withAnimation {
                        modalManager.showModal.toggle()
                        modalManager.activeModal = .profile
                    }
                }
            }
        }
        .foregroundColor(.white)
        .padding(20)
        .frame(maxWidth: 270, maxHeight: .infinity)
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SideMenu(isOpen: .constant(false), channel: .constant(Channel(channelTitle: "General", channelDescription: "Genaral is great")))
            .environmentObject(ModalManager())
            .environmentObject(UserViewModel())
            .environmentObject(MessageViewModel())
    }
}
