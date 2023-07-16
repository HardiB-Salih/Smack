//
//  HomeView.swift
//  Smack
//
//  Created by HardiB.Salih on 7/15/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var messageViewModel : MessageViewModel
    @EnvironmentObject var userViewModel : UserViewModel


    @State var message : String = ""
    @Binding var isOpen: Bool
    var channel : Channel
    
    var body: some View {

        VStack {
            navBar
            
            ScrollView {
                ForEach(Array(messageViewModel.messages.enumerated()) , id: \.offset) { index, item in
                    HStack (alignment: .top, spacing: 12){
                        Circle()
                            .fill(Color(hex: item.userAvatarColor))
                            .frame(width: 60, height: 60, alignment: .center)
                            .overlay(
                                Image(item.userAvatar)
                                    .resizable()
                                    .frame(width: 55, height: 55)
                            )
                        VStack(alignment: .leading, spacing: 12) {
                            HStack(spacing: 12){
                                Text(item.userName)
                                    .font(.headline.bold())
                                Text(item.timeStamp)
                                    .font(.footnote).foregroundColor(.secondary)
                            }
                            //Message Go
                            Text(item.message)
                                .font(.body)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }.padding(.horizontal, 12)
                        .padding(.bottom, 12)
                }
            }
            
            Spacer()
            
            HStack (spacing: 0){
                TextField(channel.channelTitle.isEmpty ? "Message:" : "Message: #\(channel.channelTitle)" , text: $message)
                    .font(.body).fontWeight(.semibold)
                Button{
                    guard let user = userViewModel.currentUser else { return }
                    messageViewModel.createMessage(
                        message: message,
                        userName: user.name,
                        channelId: channel.id,
                        userAvatar: user.avatarName,
                        userAvatarColor: user.avatarColor) { success, error in
                            if success {
                                message = ""
                            } else {
                                print("User creation in Firestore failed with error: \(error?.localizedDescription ?? "")")

                            }
                        }
                } label: {
                    Image(AssetsIcon.send.rawValue)
                        .opacity(message.isEmpty ? 0 : 1)
                        .offset(x: message.isEmpty ? 20 : 0)
                        .scaleEffect(message.isEmpty ? 0 : 1.1)
                        .animation(.spring(response: 0.5, dampingFraction: 0.7), value: message)
                    
                }
                
            }.padding(12)
                .background(Color.clear)
                .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(lineWidth: 1).fill(.black.opacity(0.1))).padding(.horizontal, 12).padding(.bottom, 30)
        }.ignoresSafeArea()
    }
    
    var navBar : some View {
        HStack {
            Button{
                withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                    isOpen.toggle()
                }
            } label: {
                Image(AssetsIcon.smackBurger.rawValue)
                    .resizable()
                    .frame(width: 22, height: 14)
                    .aspectRatio(contentMode: .fit)
            }
            .overlay(
                Circle()
                    .stroke(.linearGradient(colors: [.white.opacity(0.5), .white.opacity(0)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 40, height: 40)
            )
            
            Spacer()
            Text(channel.channelTitle.isEmpty ? "Please Log In" : "#\(channel.channelTitle)")
                .font(.headline.bold())
            Spacer()
        }
        .padding(.top, 60)
        .padding(.horizontal)
        .padding(.bottom, 12)
        .foregroundColor(.white)
        .frame(maxWidth: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color(AssetsColor.firstColor.rawValue), Color(AssetsColor.secondColor.rawValue)]), startPoint: .topLeading, endPoint: .bottomTrailing))
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(isOpen: .constant(false), channel: Channel(channelTitle: "", channelDescription: ""))
            .environmentObject(MessageViewModel())
    }
}
