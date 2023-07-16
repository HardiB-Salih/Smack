//
//  ContentView.swift
//  Smack
//
//  Created by HardiB.Salih on 7/14/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var userViewModel = UserViewModel()
    @StateObject var modalManager = ModalManager()
    @StateObject var messageViewModel = MessageViewModel()
    
    
    @State var isOpen = false
    @State var channel = Channel(channelTitle: "", channelDescription: "")
    
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(AssetsColor.firstColor.rawValue), Color(AssetsColor.secondColor.rawValue)], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            
            
            SideMenu(isOpen: $isOpen, channel: $channel)
                .environmentObject(modalManager)
                .environmentObject(userViewModel)
                .environmentObject(messageViewModel)
                .opacity(isOpen ? 1 : 0)
                .offset(x: isOpen ? 0 : -300)
                .rotation3DEffect(.degrees(isOpen ? 0 : 30), axis: (x: 0, y: 1, z: 0))
            
            HomeView(
                isOpen: $isOpen,
                channel: channel)
            .environmentObject(messageViewModel)
            .environmentObject(userViewModel)
            .background(.white)
            .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .rotation3DEffect(.degrees(isOpen ? 30 : 0), axis: (x: 0, y: -1, z: 0))
            
            .overlay(
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .opacity(isOpen ? 0.2 : 0)
                    .rotation3DEffect(.degrees(isOpen ? 30 : 0), axis: (x: 0, y: -1, z: 0))
                    .onTapGesture {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                            isOpen.toggle()
                        }
                    }
            )
            .offset(x: isOpen ? 265 : 0)
            .scaleEffect(isOpen ? 0.9 : 1)
            //                .scaleEffect(show ? 0.92 : 1)
            .ignoresSafeArea()
            
            
            if modalManager.showModal {
                ModalManagerView()
                    .transition(modalManager.activeModal == .signIn ? .move(edge: .trailing): .opacity)
                    .environmentObject(modalManager)
                    .environmentObject(userViewModel)
                    .environmentObject(messageViewModel)
            }
        }
        .onAppear {
            userViewModel.listenForCurrentUserChanges()
            messageViewModel.retrieveChannels()
        }
        .onChange(of: messageViewModel.channels) { channels in
            if let firstChannel = channels.first {
                channel = firstChannel
                messageViewModel.retrieveMessages(channelId: channel.id)

            }
        }
    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
